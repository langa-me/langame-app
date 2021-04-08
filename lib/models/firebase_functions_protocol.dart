import 'package:json_annotation/json_annotation.dart';

part 'firebase_functions_protocol.g.dart';

@JsonSerializable()
class FirebaseFunctionsResponse {
  FirebaseFunctionsResponseStatusCode statusCode =
      FirebaseFunctionsResponseStatusCode.INTERNAL;
  String? errorMessage;
  List<String>? results;
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
