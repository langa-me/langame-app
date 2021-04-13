import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/toast.dart';

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

class LangameGetAudioTokenException extends LangameException {
  LangameGetAudioTokenException(String cause) : super(cause);
}

class LangameGetChannelException extends LangameException {
  LangameGetChannelException(String cause) : super(cause);
}

class LangameSendReadyForLangameException extends LangameException {
  LangameSendReadyForLangameException(String cause) : super(cause);
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

class LangameStorageException extends LangameException {
  LangameStorageException(String cause) : super(cause);
}

const String kUserDoesNotExists = 'user_does_not_exist';
const String kNotAuthenticated = 'not_authenticated';
const String kFailedToUpdateProfile = 'failed_to_update_profile';

/// Front-end level responses
class LangameResponse<T> {
  final LangameStatus status;
  final T? result;
  final Object? error;

  LangameResponse(this.status, {this.result, this.error});

  void thenShowSnackBar(
      BuildContext context, Function onSucceed, String failedMessage,
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
        if (!kReleaseMode) throw LangameException(failedMessage);
        break;
      case LangameStatus.succeed:
        onSucceed();
        break;
    }
  }

  void thenShowToast(String succeedMessage, String failedMessage,
      {Function? onSucceed, Function? onFailure}) {
    switch (status) {
      case LangameStatus.cancelled:
        break;
      case LangameStatus.failed:
        showToast(failedMessage, color: Colors.red);
        if (onFailure != null) onFailure();
        if (!kReleaseMode) throw LangameException(failedMessage);
        break;
      case LangameStatus.succeed:
        showToast(succeedMessage, color: Colors.green);
        if (onSucceed != null) onSucceed();
        break;
    }
  }

  void thenShowToastWithContext(
      BuildContext context, String succeedMessage, String failedMessage,
      {Function? onSucceed, Function? onFailure}) {
    switch (status) {
      case LangameStatus.cancelled:
        break;
      case LangameStatus.failed:
        showToastWithContext(context, failedMessage, color: Colors.red);
        if (onFailure != null) onFailure();
        if (!kReleaseMode) throw LangameException(failedMessage);
        break;
      case LangameStatus.succeed:
        showToastWithContext(context, succeedMessage);
        if (onSucceed != null) onSucceed();
        break;
    }
  }
}

enum LangameStatus { cancelled, failed, succeed }
