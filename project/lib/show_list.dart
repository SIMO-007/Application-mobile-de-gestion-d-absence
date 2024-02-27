import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentInfo {
  final String idUser;
  final String nom;
  final String prenom;

  StudentInfo({
    required this.idUser,
    required this.nom,
    required this.prenom,
  });
}

class DisplayStudentsPage extends StatefulWidget {
  
  //final Map<String, dynamic> user_data;
  final Map<String, dynamic> submittedInfo;

  DisplayStudentsPage({
    required this.submittedInfo,
  });
  

  @override
  _DisplayStudentsPageState createState() => _DisplayStudentsPageState();
}

class _DisplayStudentsPageState extends State<DisplayStudentsPage> {
  List<StudentInfo> students = [];
  List<String> selectedAbsentStudents = [];
  Map<String, String> selectedRetardStudents = {};

  Future<List<StudentInfo>> fetchStudents() async {
    var url = Uri.parse('http://192.168.11.103/flutter/api/list_students.php?campus=${widget.submittedInfo["campus"]}&semester=${widget.submittedInfo["semester"]}&class=${widget.submittedInfo["class"]}&dept=${widget.submittedInfo["dept"]}');

    var response = await http.get(url);
    print("**************");
    print(response.body);
    if (response.statusCode == 200) {
      var responseData = response.body;

      List<dynamic> studentList = json.decode(responseData);

      return studentList.map((student) {
        return StudentInfo(
          idUser: student['id_user'],
          nom: student['nom'],
          prenom: student['prenom'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch students');
    }
  }

  void submitForm() {
    print('Selected Absent Students: $selectedAbsentStudents');
    print('Selected Retard Students: $selectedRetardStudents');
    for (var idUser in selectedAbsentStudents) {
    // Make the API call using the appropriate endpoint URL and parameters
    var url = Uri.parse('http://192.168.11.103/flutter/api/absence_prof.php?op=absent&id_user=$idUser&dept=${widget.submittedInfo["dept"]}&semester=${widget.submittedInfo["semester"]}&date=${widget.submittedInfo["date"]}');
    http.get(url);
    // Perform the API request using your preferred method (e.g., http package, Dio, etc.)
    // ...

    // Handle the API response as needed
    // ...
  }
  selectedRetardStudents.forEach((idUser, tempsRetard) {
    var url = Uri.parse('http://192.168.11.103/flutter/api/absence_prof.php?op=retard&id_user=$idUser&dept=${widget.submittedInfo["dept"]}&semester=${widget.submittedInfo["semester"]}&date=${widget.submittedInfo["date"]}&nums=$tempsRetard');
    http.get(url);
  });

  List<String> selectedAbsentStudentNames = students
      .where((student) => selectedAbsentStudents.contains(student.idUser))
      .map((student) => '${student.nom} ${student.prenom}')
      .toList();

  // Get the list of selected retard student names
  List<String> selectedRetardStudentNames = students
      .where((student) => selectedRetardStudents.containsKey(student.idUser))
      .map((student) => '${student.nom} ${student.prenom}')
      .toList();

  // Navigate to the SelectedStudentsPage and pass the selected student names
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SelectedStudentsPage(
        absentStudents: selectedAbsentStudentNames,
        retardStudents: selectedRetardStudentNames,
      ),
    ),
  );

  // Clear the selectedAbsentStudents list or perform any other necessary actions
  selectedAbsentStudents.clear();
  selectedRetardStudents.clear();
    // You can perform further operations with the selected students here
    // such as making API calls or displaying the results on another page.
    // For now, we are just printing the selected students.
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var studentList = await fetchStudents();
      setState(() {
        students = studentList;
      });
    } catch (e) {
      print('Error occurred while fetching students: $e');
    }
  }
@override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Display Students'),
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF000080), Color(0xFF4169E1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (students.isEmpty)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          '${student.nom} ${student.prenom}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        trailing: Column(
                          children: [
                            Checkbox(
                              value: selectedAbsentStudents.contains(student.idUser),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedAbsentStudents.add(student.idUser);
                                  } else {
                                    selectedAbsentStudents.remove(student.idUser);
                                  }
                                });
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                            Text(
                              'Absent',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        trailing: Column(
                          children: [
                            Checkbox(
                              value: selectedRetardStudents.containsKey(student.idUser),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedRetardStudents[student.idUser] = '';
                                  } else {
                                    selectedRetardStudents.remove(student.idUser);
                                  }
                                });
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                            Text(
                              'Retard',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Temps Retard',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(fontSize: 12.0),
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                selectedRetardStudents[student.idUser] = value;
                              } else {
                                selectedRetardStudents.remove(student.idUser);
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  );
                },
              ),
            ElevatedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}

}


class SelectedStudentsPage extends StatelessWidget {
  final List<String> absentStudents;
  final List<String> retardStudents;

  SelectedStudentsPage({required this.absentStudents, required this.retardStudents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Students'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Absent Students'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: absentStudents.length,
            itemBuilder: (context, index) {
              final studentName = absentStudents[index];
              return ListTile(
                title: Text(studentName),
              );
            },
          ),
          ListTile(
            title: Text('Retard Students'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: retardStudents.length,
            itemBuilder: (context, index) {
              final studentName = retardStudents[index];
              return ListTile(
                title: Text(studentName),
              );
            },
          ),
        ],
      ),
    );
  }
}