class UserModel {
  final String? image, id, username, namaLengkap, password;

  UserModel({
    this.image,
    this.id,
    this.username,
    this.namaLengkap,
    this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      username: data['username'] ?? '',
      namaLengkap: data['namaLengkap'] ?? '',
      password: data['password'] ?? '',
      image: data['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'username': username,
      "namaLengkap": namaLengkap,
      "password": password,
      "image": image,
    };
  }
}
