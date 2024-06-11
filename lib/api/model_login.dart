//create model for login
class ModelLogin {
  final String username;
  final String password;

  ModelLogin({
    required this.username,
    required this.password,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) {
    return ModelLogin(
      username: json['username'],
      password: json['password'],
    );
  }
}
