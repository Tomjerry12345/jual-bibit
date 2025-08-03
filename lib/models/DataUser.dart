class DataUser {
  final String? image, nama, username;

  DataUser({this.image, this.username, this.nama});

  factory DataUser.fromMap(Map<String, dynamic> data) {
    return DataUser(
      image: data["image"],
      username: data["username"],
      nama: data["namaLengkap"],
    );
  }
}
