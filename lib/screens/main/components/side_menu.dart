import 'package:admin_qurban_mart/constants.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final int index;
  final void Function(int i) onTapDrawer;
  const SideMenu({Key? key, this.index = 0, required this.onTapDrawer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: sideBgColor,
      child: ListView(
        children: [
          DrawerHeader(
            // child: Image.asset("assets/images/logo.png"),
            child: Center(
              child: Text(
                "Jual bibit",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: lineColor, width: 3),
              ),
            ),
          ),
          DrawerListTile(
            title: "Produk",
            svgSrc: Icons.bookmark,
            press: () {
              onTapDrawer(0);
            },
            selected: index == 0,
          ),
          DrawerListTile(
            title: "Transaksi",
            svgSrc: Icons.payment,
            press: () {
              onTapDrawer(1);
            },
            selected: index == 1,
          ),
          DrawerListTile(
            title: "Pengguna",
            svgSrc: Icons.location_on,
            press: () {
              onTapDrawer(2);
            },
            selected: index == 2,
          ),
          DrawerListTile(
            title: "Logout",
            svgSrc: Icons.logout,
            press: () {
              onTapDrawer(3);
            },
            selected: index == 3,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData svgSrc;
  final bool selected;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      selectedColor: Colors.green,
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: Icon(
          svgSrc,
          color: iconColor,
        ),
        title: Row(
          children: [
            SizedBox(width: 16), // H(16) bisa diganti dengan SizedBox
            Text(
              title,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        selected: selected,
      ),
    );
  }
}
