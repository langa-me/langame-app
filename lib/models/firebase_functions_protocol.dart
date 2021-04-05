import 'package:json_annotation/json_annotation.dart';

part 'firebase_functions_protocol.g.dart';

@JsonSerializable()
class FirebaseFunctionsResponse {
  final FirebaseFunctionsResponseStatusCode statusCode;
  final String? errorMessage;

  FirebaseFunctionsResponse(this.statusCode, this.errorMessage);

  factory FirebaseFunctionsResponse.fromJson(Map<String, dynamic> json) =>
      _$FirebaseFunctionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseFunctionsResponseToJson(this);
}

enum FirebaseFunctionsResponseStatusCode {
  @JsonValue(200)
  OK,
  @JsonValue(400)
  BAD_REQUEST,
  @JsonValue(401)
  UNAUTHORIZED,
  @JsonValue(500)
  INTERNAL,
}

@JsonSerializable()
class FirebaseFunctionsResponseSendLangame extends FirebaseFunctionsResponse {
  FirebaseFunctionsResponseSendLangame(
      FirebaseFunctionsResponseStatusCode statusCode,
      String? errorMessage,
      String? result)
      : super(statusCode, errorMessage);

  /// The result should be either null (error) or the notification id  retrievable in Firestore
  String? result;

  factory FirebaseFunctionsResponseSendLangame.fromJson(
          Map<String, dynamic> json) =>
      _$FirebaseFunctionsResponseSendLangameFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FirebaseFunctionsResponseSendLangameToJson(this);
}
