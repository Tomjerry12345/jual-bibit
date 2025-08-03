import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';

class TotalPenjualan extends StatelessWidget {
  final int total;
  const TotalPenjualan(
    this.total, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total penjualan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(total),
        ],
      ),
    );
  }
}
