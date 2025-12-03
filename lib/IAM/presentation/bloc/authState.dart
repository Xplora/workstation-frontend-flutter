abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String userId;
  final String token;
  AuthLoggedIn(this.userId, this.token);
}

class AuthNeedsProfile extends AuthState {
  final String userId;
  AuthNeedsProfile(this.userId);
}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
