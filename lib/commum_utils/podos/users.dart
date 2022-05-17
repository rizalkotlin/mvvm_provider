class User {
  String? idUser;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? address;

  ///contruktor class user
  User({
    this.idUser,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.address,
  });

  ///intial data user empty
  User.empty() {
    this.idUser = null;
    this.displayName = null;
    this.email = null;
    this.phoneNumber = null;
    this.address = null;
  }

  ///convert from json to object user
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'] ?? '',
      displayName: json['display_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
    );
  }

  ///convert object user to json
  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "display_name": displayName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
      };

  @override
  String toString() => toMap().toString();
}
