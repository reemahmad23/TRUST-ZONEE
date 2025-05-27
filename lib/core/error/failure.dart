abstract class Failure {
  final String message;
  final int? statusCode; // Add this line

  const Failure(this.message, [this.statusCode]); // Optional statusCode
}


class ServerFailure extends Failure {
  const ServerFailure({required String error}) : super(error);
}

class CacheFailure extends Failure {
  const CacheFailure({required String error}) : super(error);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super('Invalid Email or Password.');
}

class ServerErrorFailure extends Failure {
  const ServerErrorFailure() : super('Server error occurred.');
}

class BadRequestFailure extends Failure {
  const BadRequestFailure() : super('Bad request.');
}
class EmailAlreadyExistsFailure extends Failure {
  EmailAlreadyExistsFailure() : super( "This email has already been registered");
}
class ConnectionFailure extends Failure {
  ConnectionFailure(String message) : super(message);
}