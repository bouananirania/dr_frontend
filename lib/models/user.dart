class User {
  final String userName;
  final String password;
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;
  String? confirmNewPassword;

  User({
    required this.userName,
    required this.password,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
    this.confirmNewPassword,
  });

  // Conversion JSON -> User (pour recevoir des données depuis l'API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      password: json['password'],
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
      confirmNewPassword: json['confirmNewPassword'],
    );
  }

  // Conversion User -> JSON (pour envoyer des données à l'API)
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
