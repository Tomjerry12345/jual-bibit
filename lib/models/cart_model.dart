class Cart {
  final String? id, idProduk, pembeli, statusPenjualan, image, nama, noHp;
  final int? jumlah, harga;

  Cart(
      {this.id,
      this.idProduk,
      this.pembeli,
      this.statusPenjualan,
      this.image,
      this.nama,
      this.jumlah,
      this.harga,
      this.noHp});

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
      id: data['id'] ?? '',
      idProduk: data['idProduk'] ?? '',
      pembeli: data['pembeli'] ?? '',
      statusPenjualan: data['statusPenjualan'] ?? '',
      image: data['image'] ?? '',
      nama: data['nama'] ?? '',
      jumlah: data['jumlah'] ?? 0,
      harga: data['harga'] ?? 0,
      noHp: data['noHp'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduk': idProduk,
      'pembeli': pembeli,
      'statusPenjualan': statusPenjualan,
      'image': image,
      'nama': nama,
      'jumlah': jumlah,
      'harga': harga,
      'noHp': noHp,
    };
  }
}
