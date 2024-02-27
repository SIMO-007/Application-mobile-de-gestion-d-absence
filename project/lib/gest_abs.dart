import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/show_list.dart';
class GestAbsPage extends StatefulWidget {
  final Map<String, dynamic> user_data;

  GestAbsPage({required this.user_data});

  @override
  _GestAbsPageState createState() => _GestAbsPageState();
}

class _GestAbsPageState extends State<GestAbsPage> {
  String selectedSemester = '2';
  String selectedClass = '';
  String selectedCampus = 'Casa';
  String selectedFiliere = 'BS';
  String? selectedDate;

  List<String> semesters = ['2', '4'];
  List<String> campuses = ['Casa'];
  List<String> filieres = ['BS', 'ES'];
  List<String> dates = [];

  TextEditingController classController = TextEditingController();

  Future<List<String>> getDates() async {
    var url = Uri.parse(
        'http://192.168.11.103/flutter/api/absence_prof.php?op=getdate&id_user=${widget.user_data['id_user']}');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseData = response.body.trim();

      List<dynamic> dateList = json.decode(responseData);

      return dateList.map((date) => date.toString()).toList();
    } else {
      throw Exception('Failed to fetch dates');
    }
  }

  Future<void> submitForm() async {
    if (selectedDate != null && selectedDate!.isNotEmpty) {
      // Store the submitted info
      var submittedInfo = {
        'semester': selectedSemester,
        'class': selectedClass,
        'campus': selectedCampus,
        'dept': selectedFiliere,
        'date': selectedDate,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayStudentsPage(submittedInfo: submittedInfo),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Absences'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000080), Color(0xFF4169E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            FutureBuilder<List<String>>(
              future: getDates(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Column(
                    children: [
                      DropdownButton<String>(
                        value: selectedSemester,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSemester = newValue!;
                          });
                        },
                        items: semesters.map((semester) {
                          return DropdownMenuItem<String>(
                            value: semester,
                            child: Text(semester),
                          );
                        }).toList(),
                        hint: Text('Semester'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: classController,
                        onChanged: (newValue) {
                          setState(() {
                            selectedClass = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Class',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButton<String>(
                        value: selectedCampus,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCampus = newValue!;
                          });
                        },
                        items: campuses.map((campus) {
                          return DropdownMenuItem<String>(
                            value: campus,
                            child: Text(campus),
                          );
                        }).toList(),
                        hint: Text('Campus'),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButton<String>(
                        value: selectedFiliere,
                        onChanged: (newValue) {
                          setState(() {
                            selectedFiliere = newValue!;
                          });
                        },
                        items: filieres.map((filiere) {
                          return DropdownMenuItem<String>(
                            value: filiere,
                            child: Text(filiere),
                          );
                        }).toList(),
                        hint: Text('Filière'),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButton<String>(
                        value: selectedDate,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDate = newValue;
                          });
                        },
                        items: snapshot.data!.toSet().toList().map((date) {
                          return DropdownMenuItem<String>(
                            value: date,
                            child: Text(date),
                          );
                        }).toList(),
                        hint: Text('Date'),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: submitForm,
                        child: Text('Submit'),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

