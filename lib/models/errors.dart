class GetUserException implements Exception {
  String cause;
  GetUserException({this.cause = kUserDoesNotExists});
}

class AppleSignInException implements Exception {
  String cause;
  AppleSignInException(this.cause);
}

class FacebookSignInException implements Exception {
  String cause;
  FacebookSignInException(this.cause);
}

class GoogleSignInException implements Exception {
  String cause;
  GoogleSignInException(this.cause);
}

class FirebaseSignInException implements Exception {
  String cause;
  FirebaseSignInException({this.cause = kUserDoesNotExists});
}

class AddUserException implements Exception {
  String cause;
  AddUserException(this.cause);
}

class GetUserFriendsException implements Exception {
  String cause;
  GetUserFriendsException(this.cause);
}

class SendLangameException implements Exception {
  String cause;
  SendLangameException(this.cause);
}

const String kUserDoesNotExists = 'User does not exist';
