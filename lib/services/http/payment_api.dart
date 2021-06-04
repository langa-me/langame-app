import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;


import 'firebase.dart';

class PaymentMethodError {
  final PaymentMethod paymentMethod;
  final String? error;

  PaymentMethodError(this.paymentMethod, this.error);
}

abstract class PaymentApi {
  final FirebaseApi firebase;
  PaymentApi(this.firebase);
  Future<PaymentMethod> createPaymentMethod();
  Future<void> deletePaymentMethod(String paymentMethod);
  Stream<QuerySnapshot<PaymentMethodError>> getPaymentMethods({bool native = false});
  Future<void> subscribe(PaymentMethod paymentMethod);
  Stream<QuerySnapshot<lg.Subscription>> getSubcriptions();
}
