import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuiviAbsRetPage extends StatefulWidget {
  @override
  _SuiviAbsRetPageState createState() => _SuiviAbsRetPageState();
}

class _SuiviAbsRetPageState extends State<SuiviAbsRetPage> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();

  void _submitForm() {
    String nom = _nomController.text.trim();
    String prenom = _prenomController.text.trim();

    if (nom.isNotEmpty && prenom.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckValuesPage(nom: nom, prenom: prenom),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter both nom and prenom.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi Absences et Retards'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prenom',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckValuesPage extends StatefulWidget {
  final String nom;
  final String prenom;

  CheckValuesPage({required this.nom, required this.prenom});

  @override
  _CheckValuesPageState createState() => _CheckValuesPageState();
}

class _CheckValuesPageState extends State<CheckValuesPage> {
  List<dynamic> absences = [];
  List<dynamic> retards = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final absencesResponse = await http.get(Uri.parse(
          "http://192.168.11.103/flutter/api/suivi.php?op=abs&first=${widget.nom}&last=${widget.prenom}"));
      final retardsResponse = await http.get(Uri.parse(
          "http://192.168.11.103/flutter/api/suivi.php?op=ret&first=${widget.nom}&last=${widget.prenom}"));
          print("*****************");
          print(absencesResponse.body);
          print(retardsResponse.body);
      if (absencesResponse.statusCode == 200 &&
          retardsResponse.statusCode == 200) {
        setState(() {
          absences = jsonDecode(absencesResponse.body);
          retards = jsonDecode(retardsResponse.body);
        });
      } else {
        // Handle API error
        print('Failed to fetch data');
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
    }
  }

  Widget buildTable(List<dynamic> data, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        DataTable(
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Motif')),
          ],
          rows: data.map((record) {
            return DataRow(cells: [
              DataCell(Text(record['id_abs'].toString())),
              DataCell(Text(record['date'])),
              DataCell(Text(record['motif'])),
            ]);
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Values'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom: ${widget.nom}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Prenom: ${widget.prenom}',
              style: TextStyle(fontSize: 16),
            ),
            buildTable(absences, 'Absences'),
            buildTable(retards, 'Retards'),
          ],
        ),
      ),
    );
  }
}