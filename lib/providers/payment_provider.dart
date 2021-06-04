import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/services/http/payment_api.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
class PaymentProvider extends ChangeNotifier {
  final CrashAnalyticsProvider _cap;
  final ContextProvider _cp;
  final AuthenticationProvider _ap;
  final PaymentApi _paymentApi;
  List<PaymentMethodError> _paymentMethods = [];
  List<PaymentMethodError> get paymentMethods => _paymentMethods;
  List<lg.Subscription> _subscriptions = [];
  List<lg.Subscription> get subscriptions => _subscriptions;

  PaymentProvider(this._cap, this._cp, this._ap, this._paymentApi) {
    // TODO: change based on auth
    _paymentApi.getPaymentMethods(native: false).listen((e) {
      _cap.log('payment methods snapshot of size ${e.size}');
      e.docs.forEach((snap) {
        _paymentMethods.add(snap.data());
        notifyListeners();
      });
    });
    _paymentApi.getSubcriptions().listen((e) {
      _cap.log('subscriptions snapshot of size ${e.size}');
      e.docs.forEach((snap) {
        _subscriptions.add(snap.data());
        notifyListeners();
      });
    });
  }

  Future<LangameResponse<PaymentMethod>> createPaymentMethod() async {
    try {
      final paymentMethod = await _paymentApi.createPaymentMethod();
      return LangameResponse(LangameStatus.succeed, result: paymentMethod);
    } on PlatformException catch (e, s) {
      if (e.code.contains('cancelled'))
        return LangameResponse(LangameStatus.cancelled);
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    } catch (e, s) {
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  Future<LangameResponse<PaymentMethod>> deletePaymentMethod(
      PaymentMethod pm) async {
    try {
      await _paymentApi.deletePaymentMethod(pm.id);
      return LangameResponse(LangameStatus.succeed);
    } on PlatformException catch (e, s) {
      if (e.code.contains('cancelled'))
        return LangameResponse(LangameStatus.cancelled);
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    } catch (e, s) {
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }

  Future<LangameResponse<void>> completeSubscription(PaymentMethod pm) async {
    try {
      await _paymentApi.subscribe(pm);
      // payment was confirmed by the server without need for further authentication
      await Stripe.instance.confirmPaymentSheetPayment();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed);
    }
  }
}
