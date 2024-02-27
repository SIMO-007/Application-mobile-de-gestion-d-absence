import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GestMatPage extends StatefulWidget {
  final Map<String, dynamic> user_data;

  GestMatPage({required this.user_data});

  @override
  _GestMatPageState createState() => _GestMatPageState();
}

class _GestMatPageState extends State<GestMatPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomController = TextEditingController();
  TextEditingController nomProfController = TextEditingController();
  TextEditingController vhController = TextEditingController();
  TextEditingController semestreController = TextEditingController();
  TextEditingController deptController = TextEditingController();

  Future<void> submitForm() async {
    final url = 'http://192.168.11.103/flutter/api/gestion_matiere.php';

    if (_formKey.currentState!.validate()) {
      final response = await http.post(Uri.parse(url), body: {
        'nom': nomController.text,
        'nomprof': nomProfController.text,
        'vh': vhController.text,
        'semester': semestreController.text,
        'dept': deptController.text,
      });

      if (response.statusCode == 200) {
        final responseData = response.body;
        print("*******");
        print(responseData);
        if (responseData == 'Record added successfully!') {
          print('Record added successfully!');
          // Handle the success message here
        } else if (responseData == 'Professor not found') {
          print('Professor not found');
          // Handle the error message here
        } else {
          print('Error');
          // Handle other error responses here
        }
      } else {
        print('Error');
        // Handle the error response here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion étudiant'),
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nomController,
                    decoration: InputDecoration(labelText: 'Nom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nomProfController,
                    decoration: InputDecoration(labelText: 'Nom du professeur'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom du professeur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: vhController,
                    decoration: InputDecoration(labelText: 'VH'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le VH';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: semestreController,
                    decoration: InputDecoration(labelText: 'Semestre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le semestre';
                      }
                      return null;
                    },
                  ),SizedBox(height: 10),
                  TextFormField(
                    controller: deptController,
                    decoration: InputDecoration(labelText: 'dept'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le semestre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
