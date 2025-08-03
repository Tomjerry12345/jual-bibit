import 'package:admin_qurban_mart/models/DataUser.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class TableData extends StatefulWidget {
  const TableData({Key? key}) : super(key: key);

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    final fs = FirebaseServices();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fs.getDataStreamCollection("user"),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final docs = snapshot.data?.docs;

            List<DataUser> data = [];

            if (docs!.isNotEmpty) {
              data = docs.map((doc) {
                return DataUser.fromMap(doc.data());
              }).toList();
            }

            return Container(
              // width: 500,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: defaultPadding,
                      // minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text("Gambar"),
                        ),
                        DataColumn(
                          label: Text("Username"),
                        ),
                        DataColumn(
                          label: Text("Nama lengkap"),
                        ),
                      ],
                      rows: List.generate(
                        data.length,
                        (index) => demoDataRow(data[index]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }

  DataRow demoDataRow(DataUser data) {
    return DataRow(
      cells: [
        DataCell(Image.network(
          data.image!,
          height: 30,
          width: 30,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red);
          },
        )),
        DataCell(Text(data.username.toString())),
        DataCell(Text(data.nama.toString())),
      ],
    );
  }
}
