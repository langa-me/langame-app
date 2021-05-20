import 'firebase.dart';

abstract class PaymentApi {
  final FirebaseApi firebase;
  PaymentApi(this.firebase);
  Future<dynamic> subscribe();
}
