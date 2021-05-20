import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/payment_api.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:tuple/tuple.dart';

class AuthToPay {
  final Future<LangameResponse<void>> Function(String, String) _func;
  final String _paymentMethod;
  final String _clientSecret;
  AuthToPay(this._func, this._paymentMethod, this._clientSecret);
  Future<LangameResponse<void>> execute() =>
      _func(_paymentMethod, _clientSecret);
}

class PaymentProvider extends ChangeNotifier {
  final CrashAnalyticsProvider _cap;
  final ContextProvider _cp;
  final AuthenticationProvider _ap;
  final PaymentApi _paymentApi;
  final int price = 10;
  PaymentProvider(this._cap, this._cp, this._ap, this._paymentApi) {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            'pk_test_51IlVpjLXXrxWbxsYbi2yy1GgMn95ZH9745IOGLzaFoJ6f6nfWTKuD8syrspibAHFiOw2btICqcD7sdokAMoiXUM600eZcvzeQp',
        merchantId: 'merchant.me.langa.prod',
        androidPayMode: 'test',
      ),
    );
  }

  Future<PaymentMethod> _createPaymentMethodNative() async {
    // TODO: analytics
    _cap.log('started NATIVE payment...');
    List<ApplePayItem> items = [];
    items.add(ApplePayItem(
      label: 'Subscription',
      amount: price.toString(),
    ));
    //step 1: add card
    Token token = await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: price.toString(),
        currencyCode: 'GBP',
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'GB',
        currencyCode: 'GBP',
        items: items,
      ),
    );
    return StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: CreditCard(
          token: token.tokenId,
        ),
      ),
    );
  }

  Future<PaymentMethod> _createPaymentMethod() async {
    return StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(
      ),
    );
  }

  Future<LangameResponse<AuthToPay?>> initializePayment() async {
    try {
      _cap.log('started to check if native pay ready');
      bool? deviceSupportNativePay =
          await StripePayment.deviceSupportsNativePay();
      _cap.log(
          'device ${deviceSupportNativePay != null && deviceSupportNativePay ? '' : 'does not '}support native pay');
      // If there are no configured payment cards, this method always returns false
      bool? isNativeReady = await StripePayment.canMakeNativePayPayments([]);
      _cap.log(
          'native pay is ${isNativeReady != null && isNativeReady ? '' : 'not '}configured on this device');

      // PaymentMethod paymentMethod = await (deviceSupportNativePay != null &&
      //         deviceSupportNativePay &&
      //         isNativeReady != null &&
      //         isNativeReady
      //     ? _createPaymentMethodNative()
      //     : _createPaymentMethod());
      PaymentMethod paymentMethod = await _createPaymentMethod();
      if (paymentMethod.id == null) {
        return LangameResponse(LangameStatus.failed);
      }
      var functionsResponse = await _paymentApi.subscribe();
      _cap.log('got response from firebase functions $functionsResponse');
      var stripeResponse = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: functionsResponse['clientSecret'],
          paymentMethodId: paymentMethod.id));
      if (stripeResponse.status == 'succeeded') {
        //payment was confirmed by the server without need for futher authentification
        await StripePayment.completeNativePayRequest();
        return LangameResponse(LangameStatus.succeed);
      } else {
        // Need to authenticate before completing payment
        if (functionsResponse['client_secret'] == null ||
        stripeResponse.paymentMethodId == null) {
          throw LangamePaymentException('invalid_server_response');
        }
        
        return LangameResponse(
          LangameStatus.succeed,
          result: AuthToPay(_authAndPay, stripeResponse.paymentMethodId!,
              functionsResponse['client_secret']),
        );
      }
    } on PlatformException catch (e, s) {
      if (e.code.contains('cancelled'))
        return LangameResponse(LangameStatus.cancelled);
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    } catch (e, s) {
      await StripePayment.cancelNativePayRequest();
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  Future<LangameResponse<void>> _authAndPay(
      String paymentMethod, String clientSecret) async {
    try {
      var paymentIntentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
            paymentMethodId: paymentMethod, clientSecret: clientSecret),
      );
      //This code will be executed if the authentication is successful
      //step 5: request the server to confirm the payment with
      final statusFinal = paymentIntentResult.status;
      if (statusFinal == 'succeeded') {
        await StripePayment.completeNativePayRequest();
        return LangameResponse(LangameStatus.succeed);
      } else if (statusFinal == 'processing') {
        throw LangamePaymentException('payment_still_processing');
      } else {
        throw LangamePaymentException('payment_failed');
      }
    }
    //If Authentication fails, a PlatformException will be raised which can be handled here
    catch (e, s) {
      //case B1
      await StripePayment.cancelNativePayRequest();
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
