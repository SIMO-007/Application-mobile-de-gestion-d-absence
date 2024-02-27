import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AvancPage extends StatefulWidget {
  final Map<String, dynamic> user_data;

  AvancPage({required this.user_data});

  @override
  _AvancPageState createState() => _AvancPageState();
}

class _AvancPageState extends State<AvancPage> {
  TextEditingController _nameController = TextEditingController();

  Future<Map<String, dynamic>> fetchData(String name) async {
    var url = Uri.parse('http://192.168.11.103/flutter/api/avancement.php?op=list1&name=$name');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void _submitForm() async {
    String name = _nameController.text.trim();
    print("***********");
    print(name);
    if (name.isNotEmpty) {

      try {
        Map<String, dynamic> responseData = await fetchData(name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(responseData: responseData),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch data. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid name.'),
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
        title: Text('Avancement de Formation'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom et Prénom',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> responseData;

  ResultPage({required this.responseData});

  @override
  Widget build(BuildContext context) {
    List<dynamic> dates = responseData.values.toList();
    int score = responseData['score'];

    // Remove the last element from the dates list
    if (dates.isNotEmpty) {
      dates.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Avancement'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scéance restée:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DataTable(
              columns: [
                DataColumn(label: Text('Date')),
              ],
              rows: List<DataRow>.generate(
                dates.length,
                (index) => DataRow(cells: [
                  DataCell(Text(dates[index].toString())),
                ]),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Taux d\'avancement: $score%',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
