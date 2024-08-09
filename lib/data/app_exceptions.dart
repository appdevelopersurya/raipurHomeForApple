class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions(String? message, [this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message])
      : super(message, ' Error During Communications');
}

class BadRequestExceptions extends AppExceptions {
  BadRequestExceptions([String? message]) : super(message, ' Invalid request');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
      : super(message, ' UnAuthorized request');
}

class InvalidInputExceptions extends AppExceptions {
  InvalidInputExceptions(
    String? message,
  ) : super(message, ' Invalid Input');
}

class ApiNotRespondingException extends AppExceptions {
  ApiNotRespondingException([String? message, String? url])
      : super(message, ' Api not responded in time', url);
}

class UnSupportedMediaType extends AppExceptions {
  UnSupportedMediaType([String? message])
      : super(message, ' Unsupported Media-type');
}
