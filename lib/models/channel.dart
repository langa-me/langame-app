import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class ChannelUserLangameUser {
  int channelUid;
  String langameUid;

  ChannelUserLangameUser(this.channelUid, this.langameUid);

  factory ChannelUserLangameUser.fromJson(Map<String, dynamic> json) =>
      _$ChannelUserLangameUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelUserLangameUserToJson(this);
}

@JsonSerializable()
class LangameChannel {
  String channelName;
  List<ChannelUserLangameUser> players;
  List<String> topics;
  List<String> questions;

  LangameChannel(this.channelName, this.players, this.topics, this.questions);

  factory LangameChannel.fromJson(Map<String, dynamic> json) =>
      _$LangameChannelFromJson(json);

  Map<String, dynamic> toJson() => _$LangameChannelToJson(this);
}
