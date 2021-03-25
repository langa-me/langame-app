abstract class LangameException implements Exception {
  String cause;
  LangameException(this.cause);
}

class GetUserException extends LangameException {
  GetUserException({String cause = kUserDoesNotExists}) : super(cause);

  @override
  String toString() {
    return 'GetUserException{cause: $cause}';
  }
}

class AppleSignInException extends LangameException {
  AppleSignInException(String cause) : super(cause);

  @override
  String toString() {
    return 'AppleSignInException{cause: $cause}';
  }
}

class FacebookSignInException extends LangameException {
  FacebookSignInException(String cause) : super(cause);

  @override
  String toString() {
    return 'FacebookSignInException{cause: $cause}';
  }
}

class GoogleSignInException extends LangameException {
  GoogleSignInException(String cause) : super(cause);

  @override
  String toString() {
    return 'GoogleSignInException{cause: $cause}';
  }
}

class FirebaseSignInException extends LangameException {
  FirebaseSignInException({String cause = kUserDoesNotExists}) : super(cause);

  @override
  String toString() {
    return 'FirebaseSignInException{cause: $cause}';
  }
}

class AddUserException extends LangameException {
  AddUserException(String cause) : super(cause);

  @override
  String toString() {
    return 'AddUserException{cause: $cause}';
  }
}

class GetUserFriendsException extends LangameException {
  GetUserFriendsException(String cause) : super(cause);

  @override
  String toString() {
    return 'GetUserFriendsException{cause: $cause}';
  }
}

class SendLangameException extends LangameException {
  SendLangameException(String cause) : super(cause);

  @override
  String toString() {
    return 'SendLangameException{cause: $cause}';
  }
}

const String kUserDoesNotExists = 'User does not exist';
