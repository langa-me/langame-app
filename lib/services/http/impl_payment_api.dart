import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/stripe/protobuf/stripe.pb.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/payment_api.dart';

class ImplPaymentApi extends PaymentApi {
  ImplPaymentApi(FirebaseApi firebase) : super(firebase) {
    Stripe.merchantIdentifier = 'merchant.me.langa.prod';
    Stripe.publishableKey =
        'pk_test_51IlVpjLXXrxWbxsYbi2yy1GgMn95ZH9745IOGLzaFoJ6f6nfWTKuD8syrspibAHFiOw2btICqcD7sdokAMoiXUM600eZcvzeQp';
    Stripe.instance.applySettings();
  }

  Future<List<GetInvoicesUpcomingRequest_InvoiceItemsMessage_PriceDataMessage>>
      _getPrices() async {
    return (await firebase.firestore!
            .collection('${AppConst.firestoreProductsCollection}/prices')
            .withConverter<
                GetInvoicesUpcomingRequest_InvoiceItemsMessage_PriceDataMessage>(
              fromFirestore: (e, _) =>
                  GetInvoicesUpcomingRequest_InvoiceItemsMessage_PriceDataMessage
                      .fromJson(e.data().toString()),
              toFirestore: (e, _) => e.writeToJsonMap(),
            )
            .get())
        .docs
        .map((e) => e.data())
        .toList(); // TODO: typed
  }

  Future<PaymentMethod> _createPaymentMethodNative() async {
    throw UnimplementedError('until gpay impl in stripe lib');
    // final products = await _getPrices();
    // final price = products.first.unitAmount;
    // final currency = products.first.currency;
    // Token token = await Stripe.instance.createPaymentMethod(
    //   androidPayOptions: AndroidPayPaymentRequest(
    //     totalPrice: price.toString(),
    //     currencyCode: currency.toString(),
    //   ),
    //   applePayOptions: ApplePayPaymentOptions(
    //     currencyCode: currency.toString(),
    //     items: [
    //       ApplePayItem(
    //         label: 'Subscription',
    //         amount: price.toString(),
    //       )
    //     ],
    //   ),
    // );
    // return StripePayment.createPaymentMethod(
    //   PaymentMethodRequest(
    //     card: CreditCard(
    //       token: token.tokenId,
    //     ),
    //   ),
    // );
  }

  Future<PaymentMethod> _createCardPaymentMethod() async {
    throw UnimplementedError('until gpay impl in stripe lib');

    // return Stripe.instance.createPaymentMethod(
    //   CardFormPaymentRequest(),
    // );
  }

  @override
  Future<PaymentMethod> createPaymentMethod() async {
    print('started to check if native pay ready');
    bool deviceSupportNativePay =
        await Stripe.instance.checkApplePaySupport();
    print(
        'device ${deviceSupportNativePay ? '' : 'does not '}support native pay');

    PaymentMethod paymentMethod;
    var useNative = deviceSupportNativePay &&
        deviceSupportNativePay &&
        kReleaseMode; // Do not use native in debug
    paymentMethod = await (useNative
        ? _createPaymentMethodNative()
        : _createCardPaymentMethod());


    // Skip adding to fb if already existing
    if ((await firebase.firestore!
            .collection(AppConst.firestoreStripeCustomersCollection)
            .doc(firebase.auth!.currentUser!.uid) // TODO: fix
            .collection('payment_methods')
            .doc(paymentMethod.id)
            .get())
        .exists) return paymentMethod;
    final pm = paymentMethod.toJson();
    pm['metadata'] = {'native': useNative};
    await firebase.firestore!
        .collection(AppConst.firestoreStripeCustomersCollection)
        .doc(firebase.auth!.currentUser!.uid) // TODO: fix
        .collection('payment_methods')
        .doc(paymentMethod.id)
        .set(pm);
    return paymentMethod;
  }

  @override
  Stream<QuerySnapshot<PaymentMethodError>> getPaymentMethods(
          {bool native = false}) =>
      firebase.firestore!
          .collection(AppConst.firestoreStripeCustomersCollection)
          .doc(firebase.auth!.currentUser!.uid) // TODO: fix
          .collection('payment_methods')
          .where(FieldPath(['metadata', 'active']), isEqualTo: native)
          .withConverter<PaymentMethodError>(
            fromFirestore: (e, _) => PaymentMethodError(
                PaymentMethod.fromJson(e.data()!), e.data()!['error']),
            toFirestore: (e, _) {
              var r = e.paymentMethod.toJson();
              r['error'] = e.error;
              return r;
            },
          )
          .snapshots();

  @override
  Future<void> subscribe(PaymentMethod paymentMethod) async {
    final products = await _getPrices();
    final price = products.first.unitAmount;
    final currency = products.first.currency;
    await firebase.firestore!
        .collection(AppConst.firestoreStripeCustomersCollection)
        .doc(firebase.auth!.currentUser!.uid)
        .collection('payments')
        .add({
      'amount': price,
      'currency': currency,
      'payment_method': paymentMethod.id,
    });
  }

  @override
  Future<void> deletePaymentMethod(String paymentMethod) => firebase.firestore!
      .collection(AppConst.firestoreStripeCustomersCollection)
      .doc(firebase.auth!.currentUser!.uid)
      .collection('payment_methods')
      .doc(paymentMethod)
      .delete();

  @override
  Stream<QuerySnapshot<lg.Subscription>> getSubcriptions() =>
      firebase.firestore!
          .collection(AppConst.firestoreStripeCustomersCollection)
          .doc(firebase.auth!.currentUser!.uid)
          .collection('subscriptions')
          .where('status', isEqualTo: 'active')
          .withConverter<lg.Subscription>(
            fromFirestore: (e, _) =>
                lg.Subscription.fromJson(e.data().toString()),
            toFirestore: (e, _) => e.writeToJsonMap(),
          )
          .snapshots();
}
