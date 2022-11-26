import 'dart:developer' as dev show log;
import 'package:auth_api/src/models/user_model.dart';

/// User with a error!
class UserError extends User {
  /// User Error Constructor
  UserError({
    required this.msg,
    StackTrace? stracktrace,
    UserStatus? errorType,
  })  : _status = errorType ?? UserStatus.unknownError,
        super(
          email: 'error@user.com',
          id: '',
          username: 'error',
          emailVisibility: false,
          verified: false,
        ) {
    _init(stracktrace);
  }

  /// Error msg on user error!
  final String msg;

  ///Name speaks for itself!
  final UserStatus _status;
  void _init(StackTrace? trace) {
    dev.log(name: '**${_status.name}**', msg, level: 2000, stackTrace: trace);
  }
}

///All the possible types of user model status can be!
enum UserStatus {
  ///Name speaks for itself!
  serverError,

  ///Name speaks for itself!
  authError,

  ///Name speaks for itself!
  logicalError,

  ///Name speaks for itself!
  unknownError,

  ///Name speaks for itself!
  active,
}
