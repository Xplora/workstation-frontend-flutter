import 'package:bloc/bloc.dart';

import '../../data/models/loginRequest.dart';
import '../../data/models/registerRequest.dart';
import '../../data/repositories/authRepository.dart';

import '../../services/authSession.dart';
import 'authEvent.dart';
import 'authState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  // LOGIN
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await repo.login(
        // NOTA: Tu LoginRequest usa 'username' y 'password',
        // pero tu implementación usa 'email' en el evento.
        // Asumo que tu backend espera el email en el campo 'username'.
        LoginRequest(event.email, event.password),
      );

      if (result == null) {
        emit(AuthError("Credenciales inválidas"));
        return;
      }

      //Guardar sesión local (token + id)
      await AuthSession.saveSession(result.token, result.id);

      emit(AuthLoggedIn(result.id, result.token));
    } catch (e) {
      emit(AuthError("Error interno: $e"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final request = RegisterRequest(
        firstName: event.firstName,
        lastName: event.lastName,
        number: event.number,
        email: event.email,
        password: event.password,
        rol: event.rol,
        agencyName: event.agencyName,
        ruc: event.ruc,
      );

      final ok = await repo.register(request);

      if (!ok) {
        emit(AuthError("No se pudo registrar usuario."));
        return;
      }

      emit(AuthRegistered());
    } catch (e) {
      emit(AuthError("Error interno durante el registro: $e"));
    }
  }
}