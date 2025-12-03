class RegisterRequest {
  final String firstName;
  final String lastName;
  final String number;
  final String email;
  final String password;
  final String rol;
  final String? agencyName;
  final String? ruc;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.email,
    required this.password,
    required this.rol,
    this.agencyName,
    this.ruc,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {
      "firstName": firstName,
      "lastName": lastName,
      "number": number,
      "email": email,
      "password": password,
      "rol": rol,
    };

    if (rol == "agency") {
      jsonMap["agencyName"] = agencyName;
      jsonMap["ruc"] = ruc;
    } else {
      jsonMap["agencyName"] = "string";
      jsonMap["ruc"] = "string";
    }

    return jsonMap;
  }
}