import 'package:get/get.dart';
import 'package:qurban_mart/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qurban_mart/controller/produk_controller.dart';
import 'package:qurban_mart/values/output_utils.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    final produkController = Get.find<ProdukController>();

    return TextFormField(
      onChanged: (value) {
        logO("cari", m: value);
        produkController.cari.value = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Cari",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
          child: SvgPicture.asset(
            "assets/icons/Search.svg",
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.3),
                BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
