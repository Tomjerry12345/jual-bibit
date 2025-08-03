import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../components/header/header_component.dart';

import '../../models/Data.dart';
import 'components/table_data.dart';

class CustomersScreen extends StatefulWidget {
  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderComponent(
              title: "Pengguna",
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      TableData(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
