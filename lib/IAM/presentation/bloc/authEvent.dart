abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String number;
  final String email;
  final String password;
  final String rol;
  final String? agencyName;
  final String? ruc;

  RegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.email,
    required this.password,
    required this.rol,
    this.agencyName,
    this.ruc,
  });
}