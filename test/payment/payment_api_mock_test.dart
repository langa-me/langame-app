// import 'package:langame/helpers/constants.dart';
// import 'package:langame/models/errors.dart';
// import 'package:langame/services/http/firebase.dart';
// import 'package:langame/services/http/impl_payment_api.dart';
// import 'package:test/test.dart';

// import '../mock_firebase_functions.dart';

// void main() {
//   group('ImplPaymentApi', () {
//     late MockFirebaseFunctions functions;
//     late FirebaseApi firebase;
//     late ImplPaymentApi api;
//     test('Empty response should throw LangamePaymentException', () async {
//       functions = MockFirebaseFunctions.withResponses({
//         AppConst.createStripeSubscriptionFunction: {},
//       });
//       firebase = FirebaseApi(
//         functions: functions,
//         useEmulator: false,
//       );
//       api = ImplPaymentApi(firebase);
//       expect(() async => await api.pay(1337, 'ethereum', 'coinbase'),
//           throwsA(const TypeMatcher<LangamePaymentException>()));
//     });

//     test('BAD_REQUEST', () async {
//       functions = MockFirebaseFunctions.withResponses({
//         AppConst.createStripeSubscriptionFunction: {
//           'statusCode': 400,
//         },
//       });
//       firebase = FirebaseApi(
//         functions: functions,
//         useEmulator: false,
//       );
//       api = ImplPaymentApi(firebase);
//       expect(() async => await api.pay(666, 'bitcoin', 'foobar'),
//           throwsA(const TypeMatcher<LangamePaymentException>()));
//     });

//     test('Unauthorized', () async {
//       functions = MockFirebaseFunctions.withResponses({
//         AppConst.createStripeSubscriptionFunction: {
//           'statusCode': 401,
//         },
//       });
//       firebase = FirebaseApi(
//         functions: functions,
//         useEmulator: false,
//       );
//       api = ImplPaymentApi(firebase);
//       expect(() async => await api.pay(20, 'dogecoin', 'bills'),
//           throwsA(const TypeMatcher<LangamePaymentException>()));
//     });

//     test('INTERNAL', () async {
//       functions = MockFirebaseFunctions.withResponses({
//         AppConst.createStripeSubscriptionFunction: {
//           'statusCode': 500,
//         },
//       });
//       firebase = FirebaseApi(
//         functions: functions,
//         useEmulator: false,
//       );
//       api = ImplPaymentApi(firebase);
//       expect(() async => await api.pay(20, 'dogecoin', 'gold'),
//           throwsA(const TypeMatcher<LangamePaymentException>()));
//     });

//     test('OK', () async {
//       Map<String, dynamic> expectedResult = {
//         'paymentIntent': {
//           'status': 'succeeded',
//           'client_secret': 'very_secret',
//           'payment_method': 'dogecoin',
//         },
//         'stripeAccount': 'bob',
//       };
//       functions = MockFirebaseFunctions.withResponses({
//         AppConst.createStripeSubscriptionFunction: {
//           'statusCode': 200,
//           'result': expectedResult,
//         },
//       });
//       firebase = FirebaseApi(
//         functions: functions,
//         useEmulator: false,
//       );
//       api = ImplPaymentApi(firebase);
//       var result = await api.pay(
//           20, expectedResult['paymentIntent']['payment_method'], 'gold');
//       expect(result, equals(expectedResult));
//     });
//   });
// }
