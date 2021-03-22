class GetUserException implements Exception {
  String cause;
  GetUserException(this.cause);
}

class GetUserFriendsException implements Exception {
  String cause;
  GetUserFriendsException(this.cause);
}

class SendLangameException implements Exception {
  String cause;
  SendLangameException(this.cause);
}
