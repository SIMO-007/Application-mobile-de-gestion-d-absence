import 'package:flutter/material.dart';
import 'package:project/login_etud.dart';
import 'package:project/cons_abs.dart';
import 'package:project/cons_retard.dart';

class EspaceEtudPage extends StatelessWidget {
  @override
  final Map<String, dynamic> user_data;

  EspaceEtudPage({required this.user_data});

  
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espace Étudiant'),
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
          
          //padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text('Response:'),
              //Text('$user_data'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConsAbsPage(user_data: this.user_data)),
                  );
                },
                child: Text('Consulter Absences'),
              ),
              
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConsRetardPage(user_data: this.user_data)),
                  );
                },
                child: Text('Consulter Retard'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginEtudPage()),
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
        

      ),
    );
  }
}
