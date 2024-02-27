import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GestEtudPage extends StatefulWidget {
  final Map<String, dynamic> user_data;

  GestEtudPage({required this.user_data});

  @override
  _GestEtudPageState createState() => _GestEtudPageState();
}

class _GestEtudPageState extends State<GestEtudPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController campusController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController semestreController = TextEditingController();

  Future<void> submitForm() async {
    final url = 'http://192.168.11.103/flutter/api/gestion_user.php';

    if (_formKey.currentState!.validate()) {
      final response = await http.post(Uri.parse(url), body: {
        'nom': nomController.text,
        'prenom': prenomController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'confirm_mdp': confirmPasswordController.text,
        'campus': campusController.text,
        'dept': deptController.text,
        'semestre': semestreController.text,
      });

      if (response.statusCode == 200) {
        print('Success');
        print(response.body);
        // Process the success response here
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
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: prenomController,
                    decoration: InputDecoration(labelText: 'Prénom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre prénom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(labelText: 'Confirmer le mot de passe'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: campusController,
                    decoration: InputDecoration(labelText: 'Campus'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le campus';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: deptController,
                    decoration: InputDecoration(labelText: 'Département'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le département';
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
