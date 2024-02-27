import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsAbsPage extends StatefulWidget {
  Map<String, dynamic> user_data;

  ConsAbsPage({required this.user_data});

  @override
  _ConsAbsPageState createState() => _ConsAbsPageState();
}

class _ConsAbsPageState extends State<ConsAbsPage> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    var url = Uri.parse('http://192.168.11.103/flutter/api/absence_user.php?op=absences&id_user=${widget.user_data['id_user']}&nom=${widget.user_data['nom']}&prenom=${widget.user_data['prenom']}&class=${widget.user_data['class']}&email=${widget.user_data['email']}&password=${widget.user_data['password']}&semester=${widget.user_data['semester']}&etat=${widget.user_data['etat']}&stage=${widget.user_data['stage']}&campus=${widget.user_data['campus']}&dept=${widget.user_data['dept']}&role=${widget.user_data['role']}&rachat=${widget.user_data['rachat']}&redoublant=${widget.user_data['redoublant']}');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseData = response.body.trim();

      // Parse the JSON response
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(responseData));

      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulter Absences'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000080), Color(0xFF4169E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];

                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: ListTile(
                      title: Text(
                        'Date: ${item['date']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Motif: ${item['motif']}',
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
