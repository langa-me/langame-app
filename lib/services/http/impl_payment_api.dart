import 'package:cloud_functions/cloud_functions.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/payment_api.dart';

class ImplPaymentApi extends PaymentApi {
  ImplPaymentApi(FirebaseApi firebase) : super(firebase);

  @override
  Future<dynamic> subscribe() async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
      AppConst.createStripeSubscriptionFunction,
      options: HttpsCallableOptions(
        timeout: Duration(seconds: 10),
      ),
    );

    try {
      final HttpsCallableResult result =
          await callable.call<Map<String, dynamic>>(
        <String, dynamic>{
          'priceId': 'price_1Is1SDLXXrxWbxsYf4dOnKwr',
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
          Map<String, dynamic>.from(result.data));
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          return response.result;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangamePaymentException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangamePaymentException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangamePaymentException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangamePaymentException(e.toString());
    }
  }
}
