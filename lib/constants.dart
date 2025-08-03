import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';

const baseUrl = 'https://jadngzdbesapklpkaesw.supabase.co';
const apiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImphZG5nemRiZXNhcGtscGthZXN3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg2NzMwMzQsImV4cCI6MjA2NDI0OTAzNH0.bWzrOq9vG952pPeMDZ5OrBowoYYMBq0yoFjC45faIsg';

const noHp = "85753845575";
const lokasi = GeoPoint(-5.1477, 119.4327);

// Just for demo
const productDemoImg1 =
    "https://awsimages.detik.net.id/community/media/visual/2022/07/09/torpedo-kambing-4.jpeg?w=600&q=90";
const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

// End For demo

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: 'Username is required'),
  MinLengthValidator(4,
      errorText: 'Username must be at least 4 characters long'),
  PatternValidator(r'^[a-zA-Z0-9_]+$',
      errorText:
          'Username can only contain alphanumeric characters and underscores'),
]);

final namaLengkapdValidator = MultiValidator([
  RequiredValidator(errorText: 'Nama lengkap is required'),
]);

const pasNotMatchErrorText = "passwords do not match";

const KEY_USERNAME = "username";
const belumTerjual = "Belum terjual";

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
