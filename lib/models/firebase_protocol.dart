import 'package:json_annotation/json_annotation.dart';

part 'firebase_protocol.g.dart';

@JsonSerializable()
class FirebaseMessage {
  final LangameStatusCode statusCode;
  final String? errorMessage;

  FirebaseMessage(this.statusCode, this.errorMessage);

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessageFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LangameUserToJson`.
  Map<String, dynamic> toJson() => _$FirebaseMessageToJson(this);
}

enum LangameStatusCode {
  @JsonValue(200)
  OK,
  @JsonValue(400)
  BAD_REQUEST,
  @JsonValue(401)
  UNAUTHORIZED,
}

@JsonSerializable()
class FirebaseMessageSendLangame extends FirebaseMessage {
  FirebaseMessageSendLangame(
      LangameStatusCode statusCode, String? errorMessage, String? result)
      : super(statusCode, errorMessage);

  /// The result should be either null (error) or the notification id  retrievable in Firestore
  String? result;

  factory FirebaseMessageSendLangame.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessageSendLangameFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessageSendLangameToJson(this);
}
