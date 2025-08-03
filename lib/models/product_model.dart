import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id,
      image,
      nama,
      kategori,
      noHp,
      status,
      statusPengiriman,
      statusPembayaran,
      namaPenjual,
      noRekening,
      buktiPembayaran,
      idCart;
  final GeoPoint? lokasi;
  final int? harga, usia, berat, jumlah;
  // final bool? isPemesan;

  Product({
    this.id,
    this.image,
    this.nama,
    this.usia,
    this.berat,
    this.harga,
    this.jumlah,
    this.kategori,
    this.lokasi,
    this.noHp,
    this.status,
    this.statusPengiriman,
    this.statusPembayaran,
    this.namaPenjual,
    this.noRekening,
    this.buktiPembayaran,
    this.idCart,
    // this.isPemesan
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? '',
      nama: data['nama'] ?? '',
      harga: data['harga'] ?? 0,
      jumlah: data['jumlah'] ?? 0,
      kategori: data['kategori'] ?? '',
      usia: data['usia'] ?? 0,
      berat: data['berat'] ?? 0,
      lokasi: data['location'],
      noHp: "+62${data['noHp']}",
      image: data['image'] ?? '',
      status: data['status'] ?? '',
      statusPengiriman: data['statusPengiriman'] ?? '',
      statusPembayaran: data['statusPembayaran'] ?? '',
      namaPenjual: data['namaPenjual'] ?? '',
      noRekening: data['noRekening'] ?? '',
      buktiPembayaran: data['buktiPembayaran'] ?? '',
      idCart: data['idCart'] ?? '',
      // isPemesan: data['isPemesan'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'kategori': kategori,
      'usia': usia,
      'berat': berat,
      'lokasi': lokasi,
      'noHp': noHp,
      'status': status,
      'statusPengiriman': statusPengiriman,
      'statusPembayaran': statusPembayaran,
      'namaPenjual': namaPenjual,
      'noRekening': noRekening,
      'buktiPembayaran': buktiPembayaran,
      'idCart': idCart,
      // 'isPemesan': isPemesan,
    };
  }
}
