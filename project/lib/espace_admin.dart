import 'package:flutter/material.dart';
import 'package:project/login_admin.dart';

import 'package:project/stats.dart';
import 'package:project/avanc.dart';
import 'package:project/suivi_abs_ret.dart';
import 'package:project/gest_etud.dart';
import 'package:project/gest_prof.dart';
import 'package:project/gest_mat.dart';

class EspaceAdminPage extends StatelessWidget {
  final Map<String, dynamic> user_data;

  EspaceAdminPage({required this.user_data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espace Admin'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000080), Color(0xFF4169E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatsPage()),
                  );
                },
                child: Text('Statistiques'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AvancPage(user_data: user_data)),
                  );
                },
                child: Text('Avancement de formation'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuiviAbsRetPage()),
                  );
                },
                child: Text('Suivi d\'absences et de retards'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestEtudPage(user_data: user_data)),
                  );
                },
                child: Text('Gestion étudiants'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestProfPage(user_data: user_data)),
                  );
                },
                child: Text('Gestion professeurs'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestMatPage(user_data: user_data)),
                  );
                },
                child: Text('Gestion matières'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginAdminPage()),
                  );
                },
                child: Text('Déconnexion'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginAdminPage()),
          );
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
