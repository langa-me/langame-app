/// API / service level errors
class LangameException implements Exception {
  String cause;
  LangameException(this.cause);

  @override
  String toString() {
    return '${this.runtimeType.toString()}{cause: $cause}';
  }
}

class LangameAuthException extends LangameException {
  LangameAuthException(String cause) : super(cause);
}

class LangameGetUserException extends LangameException {
  LangameGetUserException({String cause = kUserDoesNotExists}) : super(cause);
}

class LangameAppleSignInException extends LangameException {
  LangameAppleSignInException(String cause) : super(cause);
}

class LangameGoogleSignInException extends LangameException {
  LangameGoogleSignInException(String cause) : super(cause);
}

class LangameFirebaseSignInException extends LangameException {
  LangameFirebaseSignInException({String cause = kUserDoesNotExists})
      : super(cause);
}

class LangameAddUserException extends LangameException {
  LangameAddUserException(String cause) : super(cause);
}

class LangameGetUserFriendsException extends LangameException {
  LangameGetUserFriendsException(String cause) : super(cause);
}

class LangameSendLangameException extends LangameException {
  LangameSendLangameException(String cause) : super(cause);
}

class LangamePaymentException extends LangameException {
  LangamePaymentException(String cause) : super(cause);
}

class LangameGetAudioTokenException extends LangameException {
  LangameGetAudioTokenException(String cause) : super(cause);
}

class LangameSendEndException extends LangameException {
  LangameSendEndException(String cause) : super(cause);
}

class LangameGetChannelException extends LangameException {
  LangameGetChannelException(String cause) : super(cause);
}

class LangameNotifyPresenceException extends LangameException {
  LangameNotifyPresenceException(String cause) : super(cause);
}

class LangameUpdateProfileException extends LangameException {
  LangameUpdateProfileException({String cause = kFailedToUpdateProfile})
      : super(cause);
}

class LangameMessageException extends LangameException {
  LangameMessageException(String cause) : super(cause);
}

class LangameNotAuthenticatedException extends LangameException {
  LangameNotAuthenticatedException({String cause = kNotAuthenticated})
      : super(cause);
}

class LangameMessagePermissionException extends LangameException {
  LangameMessagePermissionException(String cause) : super(cause);
}

class LangamePreferencesException extends LangameException {
  LangamePreferencesException(String cause) : super(cause);
}

const String kUserDoesNotExists = 'user_does_not_exist';
const String kNotAuthenticated = 'not_authenticated';
const String kFailedToUpdateProfile = 'failed_to_update_profile';

/// Front-end level responses
class LangameResponse<T> {
  late LangameStatus status;
  late T? result;
  Object? error;

  LangameResponse(this.status, {this.result, this.error});
  LangameResponse.succeed({this.result}) {
    status = LangameStatus.succeed;
    error = null;
  }
  LangameResponse.failed({this.error}) {
    result = null;
    status = LangameStatus.failed;
  }
  LangameResponse.cancelled({this.error}) {
    result = null;
    status = LangameStatus.cancelled;
  }
}

enum LangameStatus { cancelled, failed, succeed }
