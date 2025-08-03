class Product {
  final String? id, idCart, image, nama, noHp;
  final int? harga, jumlah;

  Product({
    this.id,
    this.idCart,
    this.image,
    this.nama,
    this.noHp,
    this.harga,
    this.jumlah,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? '',
      idCart: data['idCart'] ?? '',
      image: data['image'] ?? '',
      nama: data['nama'] ?? '',
      noHp: data['noHp'] ?? '',
      harga: data['harga'] ?? 0,
      jumlah: data['jumlah'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCart': idCart,
      'image': image,
      'nama': nama,
      'noHp': noHp,
      'harga': harga,
      'jumlah': jumlah,
    };
  }
}
