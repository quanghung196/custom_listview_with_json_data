
class TheMovieDBException implements Exception {
  final _message;
  final _prefix;

  TheMovieDBException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends TheMovieDBException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends TheMovieDBException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends TheMovieDBException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends TheMovieDBException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
