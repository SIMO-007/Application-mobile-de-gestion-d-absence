import 'package:flutter/material.dart';
import 'package:project/login_prof.dart';
import 'package:project/gest_abs.dart';
import 'package:project/stats.dart';
import 'package:project/avanc.dart';
import 'package:project/suivi_abs_ret.dart';

class EspaceProfPage extends StatelessWidget {
  final Map<String, dynamic> user_data;

  EspaceProfPage({required this.user_data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espace Prof'),
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
                    MaterialPageRoute(builder: (context) => GestAbsPage(user_data: user_data)),
                  );
                },
                child: Text('Gestion Absences'),
              ),
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
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginProfPage()),
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
            MaterialPageRoute(builder: (context) => LoginProfPage()),
          );
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
