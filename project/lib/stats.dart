import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Future<Map<String, dynamic>> fetchData() async {
    var url = Uri.parse('http://192.168.11.103/flutter/api/statistiques.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiques'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> elemData = snapshot.data!;
            List<Widget> tables = [];

            elemData.forEach((key, value) {
              List<dynamic> elemList = jsonDecode(value);

              List<DataColumn> columns = [];
              List<DataRow> rows = [];

              if (elemList.isNotEmpty) {
                var item = elemList[0];

                item.keys.forEach((elemKey) {
                  columns.add(DataColumn(label: Text(elemKey)));
                });

                elemList.forEach((item) {
                  List<DataCell> cells = [];

                  item.forEach((elemKey, elemValue) {
                    cells.add(DataCell(Text(elemValue.toString())));
                  });

                  rows.add(DataRow(cells: cells));
                });
              }

              Widget table = SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(columns: columns, rows: rows),
                ),
              );

              tables.add(Column(
                children: [
                  Text(
                    key,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  table,
                ],
              ));
            });

            return ListView(children: tables);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
