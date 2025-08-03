import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/screens/customers/customers_screen.dart';
import 'package:admin_qurban_mart/screens/product/map/maps_screen.dart';
import 'package:admin_qurban_mart/screens/product/product_screen.dart';
import 'package:admin_qurban_mart/screens/product/tambah/tambah_products.dart';
import 'package:admin_qurban_mart/screens/product/view/view_products.dart';
import 'package:admin_qurban_mart/screens/transaksi/transaksi_screen.dart';
import 'package:flutter/material.dart';

Widget generateRoute(String route) {
  switch (route) {
    case managementProductScreenRoute:
      return ProductScreen();
    case managementTransaksiScreenRoute:
      return TransaksiScreen();
    case tambahProductScreenRoute:
      return TambahProducts();
    case managementCustomerScreenRoute:
      return CustomersScreen();
    case viewProductScreenRoute:
      return ViewProducts();
    case mapsScreenRoute:
      return MapsScreen();
    default:
      return ProductScreen();
  }
}
