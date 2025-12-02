import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authBloc.dart';
import '../bloc/authEvent.dart';
import '../bloc/authState.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;
  bool obscurePass = true;
  bool obscureConfirm = true;
  String accountType = "tourist";

  bool _acceptTerms = false;

  // CONTROLLERS
  final emailLoginCtrl = TextEditingController();
  final passLoginCtrl = TextEditingController();

  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  final primary = const Color(0xFF2EBFAF);

  BuildContext? _loadingDialogContext;

  void _showMessage(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showLoadingDialog() {
    // Solo muestra si no hay un diálogo ya visible
    if (_loadingDialogContext != null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        _loadingDialogContext = dialogContext;

        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 15),
              Text("Cargando..."),
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (_loadingDialogContext != null) {
      Navigator.of(_loadingDialogContext!).pop();
      _loadingDialogContext = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          _showLoadingDialog();
        } else if (state is AuthLoggedIn) {
          _showMessage("Inicio de sesión exitoso.", primary);
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthRegistered) {
          _showMessage("¡Registro Exitoso! Inicia sesión ahora.", primary);
          setState(() {
            isLogin = true;
            emailLoginCtrl.text = emailCtrl.text;
            fullNameCtrl.clear();
            emailCtrl.clear();
            phoneCtrl.clear();
            passCtrl.clear();
            confirmPassCtrl.clear();
          });
        } else if (state is AuthError) {
          _hideLoadingDialog();
          _showMessage(state.message, Colors.red);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  isLogin ? "Hello" : "Welcome",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B6265),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isLogin ? "Log in to your account" : "Register to get started",
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _tabButton("Log In", isLogin, () {
                        setState(() => isLogin = true);
                      }),
                      _tabButton("Sign Up", !isLogin, () {
                        setState(() => isLogin = false);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                if (isLogin) _loginForm(),
                if (!isLogin) _registerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────
  // LOGIN VIEW
  // ───────────────────────────────────────────────
  Widget _loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _input("Correo", controller: emailLoginCtrl),
        const SizedBox(height: 20),

        _passwordInput("Password", obscurePass, () {
          setState(() => obscurePass = !obscurePass);
        }, controller: passLoginCtrl),

        const SizedBox(height: 30),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: loginUser,
            child: const Text("Log In", style: TextStyle(color: Colors.white)),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Are you new here? "),
            GestureDetector(
              onTap: () => setState(() => isLogin = false),
              child: Text(
                "Create an account",
                style: TextStyle(color: primary, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
    );
  }

  // ───────────────────────────────────────────────
  // REGISTER VIEW
  // ───────────────────────────────────────────────
  Widget _registerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _input("Full Name", controller: fullNameCtrl),
        const SizedBox(height: 15),

        _input("Correo", controller: emailCtrl),
        const SizedBox(height: 15),

        Row(
          children: [
            _countryCode(),
            const SizedBox(width: 10),
            Expanded(child: _input("Phone Number", controller: phoneCtrl)),
          ],
        ),
        const SizedBox(height: 15),

        _passwordInput("Password", obscurePass, () {
          setState(() => obscurePass = !obscurePass);
        }, controller: passCtrl),

        const SizedBox(height: 15),

        _passwordInput("Confirm Password", obscureConfirm, () {
          setState(() => obscureConfirm = !obscureConfirm);
        }, controller: confirmPassCtrl),

        const SizedBox(height: 20),

        const Text("Account type",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),

        Row(
          children: [
            Radio(
              value: "tourist",
              groupValue: accountType,
              onChanged: (v) => setState(() => accountType = v!),
              activeColor: primary,
            ),
            const Text("Tourist"),
            const SizedBox(width: 20),
            Radio(
              value: "agency",
              groupValue: accountType,
              onChanged: (v) => setState(() => accountType = v!),
              activeColor: primary,
            ),
            const Text("Agency"),
          ],
        ),

        const SizedBox(height: 20),

        _termsAndConditions(),

        const SizedBox(height: 20),

        SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: registerUser,
            child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            GestureDetector(
              onTap: () => setState(() => isLogin = true),
              child: Text(
                "Sign in",
                style: TextStyle(color: primary, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // API: LOGIN
  // ───────────────────────────────────────────────
  Future<void> loginUser() async {
    context.read<AuthBloc>().add(
      LoginEvent(
        emailLoginCtrl.text,
        passLoginCtrl.text,
      ),
    );
  }

  // ───────────────────────────────────────────────
  // API: REGISTER
  // ───────────────────────────────────────────────
  Future<void> registerUser() async {
    void showMessage(String message, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
        ),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: color,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }

    if (passCtrl.text.trim() != confirmPassCtrl.text.trim()) {
      showMessage("Error: Las contraseñas no coinciden.", Colors.red);
      return;
    }
    if (!_acceptTerms) {
      showMessage("Debes aceptar los Términos y Condiciones.", Colors.red);
      return;
    }

    final fullName = fullNameCtrl.text.trim();
    final split = fullName.split(" ");

    context.read<AuthBloc>().add(
      RegisterEvent(
        firstName: split.first,
        lastName: split.length > 1 ? split.sublist(1).join(" ") : "",
        number: phoneCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
        rol: accountType,
        agencyName: "",
        ruc: "",
      ),
    );
  }

  // ───────────────────────────────────────────────
  // WIDGETS
  // ───────────────────────────────────────────────
  Widget _tabButton(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 38,
        decoration: BoxDecoration(
          color: active ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _countryCode() {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: "+51",
          items: const [
            DropdownMenuItem(value: "+51", child: Text("+51")),
            DropdownMenuItem(value: "+1", child: Text("+1")),
            DropdownMenuItem(value: "+34", child: Text("+34")),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _input(String hint, {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _passwordInput(
      String hint, bool obscure, VoidCallback toggle,
      {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  Widget _termsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (bool? newValue) {
            setState(() {
              _acceptTerms = newValue ?? false;
            });
          },
          activeColor: primary,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              // Acción: Navegar a la página de T&C o mostrar un diálogo
              Navigator.pushNamed(context, '/terms');
            },
            child: Text.rich(
              TextSpan(
                text: "He leído y acepto los ",
                style: const TextStyle(fontSize: 13, color: Colors.black54),
                children: [
                  TextSpan(
                    text: "Términos y Condiciones",
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
