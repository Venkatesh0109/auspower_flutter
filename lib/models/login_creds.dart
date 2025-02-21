class LoginCreds {
  String email;
  String? password;
  bool isGoogleLogin;
  LoginCreds({required this.email, this.password, this.isGoogleLogin = false});
  factory LoginCreds.fromJson(Map<String, dynamic> json) {
    return LoginCreds(email: json["email"], password: json["password"]);
  }
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "is_google": isGoogleLogin};
  }
}
