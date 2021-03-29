import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:langame/models/relation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class LangameUser {
  /// [uid] is set by Firebase authentication
  final String? uid; // TODO: shouldn't be nullable
  final String? email;
  final String? displayName;
  // bool emailVerified = false;
  final String? phoneNumber;
  final String? photoUrl;

  /// Is the user [online]?
  bool online = false;

  /// Google account linked?
  bool google = false;

  /// Facebook account linked?
  bool facebook = false;

  /// Apple account linked?
  bool apple = false;

  /// Favourite topics the user has picked, should impact recommendations
  List<String>? favouriteTopics;

  /// [isALangameUser] signifies whether this user is an imported contact
  /// or really someone who registered on Langame
  bool isALangameUser = false;

  /// Twitter-like [tag] i.e. @steveTheApple
  String? tag;

  /// Device [tokens] used for Cloud Messaging
  List<String>? tokens;

  LangameUser({
    this.uid,
    this.email,
    this.displayName,
    // this.emailVerified = false,
    this.phoneNumber,
    this.photoUrl,
    this.online = false,
    this.tag,
    this.google = false,
    this.facebook = false,
    this.apple = false,
    this.favouriteTopics,
  });

  LangameUser.fromFirebaseUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName,
        // emailVerified = user.emailVerified, // TODO: temporary hack to make test pass (PR mock firebase auth)
        phoneNumber = user.phoneNumber,
        photoUrl = user.photoURL;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$LangameUserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LangameUser.fromJson(Map<String, dynamic> json) =>
      _$LangameUserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LangameUserToJson`.
  Map<String, dynamic> toJson() => _$LangameUserToJson(this);
}

class LangameUserRelations {
  final LangameUser user;
  final List<Relation> relations;

  LangameUserRelations(this.user, this.relations);
}

/// https://pub.dev/packages/flutter_facebook_auth#methods
class FacebookUser {
  final int id;
  final String? firstname;
  final String? lastName;
  final String? middleName;
  final String? name;
  final String? nameFormat;
  final Map<String, dynamic>? picture;
  final String? shortName;

  FacebookUser(this.id,
      {this.firstname,
      this.lastName,
      this.middleName,
      this.name,
      this.nameFormat,
      this.picture,
      this.shortName});

  // TODO JSON
}

class AppleUser {}
