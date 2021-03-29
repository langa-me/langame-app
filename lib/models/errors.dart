import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class LangameException implements Exception {
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

class LangameFacebookSignInException extends LangameException {
  LangameFacebookSignInException(String cause) : super(cause);
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

class LangameMessageException extends LangameException {
  LangameMessageException(String cause) : super(cause);
}

class LangameNotAuthenticatedException extends LangameException {
  LangameNotAuthenticatedException({String cause = kNotAuthenticated})
      : super(cause);
}

const String kUserDoesNotExists = 'user_does_not_exist';
const String kNotAuthenticated = 'not_authenticated';

class LangameResponse {
  final LangameStatus status;
  final String? errorMessage;

  LangameResponse(this.status, {this.errorMessage});

  handle(BuildContext context, Function onSucceed, String failedMessage,
      {Function? onFailure}) {
    switch (status) {
      case LangameStatus.cancelled:
        break;
      case LangameStatus.failed:
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(failedMessage),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (onFailure != null) onFailure();
        if (!kReleaseMode) throw LangameAuthException(failedMessage);
        break;
      case LangameStatus.succeed:
        onSucceed();
        break;
    }
  }
}

enum LangameStatus { cancelled, failed, succeed }
