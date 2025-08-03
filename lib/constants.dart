import 'package:flutter/material.dart';

const baseUrl = 'https://jadngzdbesapklpkaesw.supabase.co';
const apiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImphZG5nemRiZXNhcGtscGthZXN3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg2NzMwMzQsImV4cCI6MjA2NDI0OTAzNH0.bWzrOq9vG952pPeMDZ5OrBowoYYMBq0yoFjC45faIsg';

Color? primaryColor = Colors.green[800];
const secondaryColor = Color.fromARGB(255, 83, 83, 83);
const inputFillColor = Color(0xFFC8E6C9);
const inputHintColor = Color.fromARGB(255, 118, 174, 120);
const inputTextColor = Color(0xFF516C51);
const buttonColor = Color(0xFF43A047);
const headingColor = Color(0xFF1B5E20);
const iconColor = Color(0xFF2E7D32);
const inputBorderColor = Color(0xFF66BB6A);
const disabledColor = Color.fromARGB(255, 114, 212, 119);
const bgColor = Color(0xFFE8F5E9);
const textColor = Color.fromARGB(255, 46, 69, 46);
const cardColor = Color(0xFFC8E6C9);

const sideBgColor = Color.fromARGB(255, 174, 243, 178);
const lineColor = Color.fromARGB(255, 104, 175, 107);

const tabActivateColor = Color(0xFF43A047);
const tabNotactivateColor = Color.fromARGB(255, 107, 183, 111);

const defaultPadding = 16.0;

const KEY_ISLOGGING = "is-logging";

enum StatusPenjualan {
  belumTerjual("Belum terjual"),
  terjual("Terjual");

  final String deskripsi;

  const StatusPenjualan(this.deskripsi);
}

enum StatusPengiriman {
  belumDikirim("Belum dikirim"),
  sedangDiantar("Sedang diantar"),
  pesananSelesai("Pesanan selesai");

  final String deskripsi;

  const StatusPengiriman(this.deskripsi);
}

enum StatusPembayaran {
  belumDibayar("Belum dibayar"),
  pembayaranDiProses("Pembayaran di proses"),
  pembayaranBerhasil("Pembayaran berhasil"),
  pembayaranGagal("Pembayaran gagal");

  final String deskripsi;

  const StatusPembayaran(this.deskripsi);
}
