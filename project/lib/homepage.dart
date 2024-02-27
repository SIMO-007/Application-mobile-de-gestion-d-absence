import 'package:flutter/material.dart';
import 'package:project/login_etud.dart';
import 'package:project/login_admin.dart';
import 'package:project/login_prof.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Image.asset(
                  'assets/images/HEMnew.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
            SizedBox(height: 10), // Adjust the height as desired
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginEtudPage()),
                      );
                    },
                    child: Text('étudiant'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginAdminPage()),
                      );
                    },
                    child: Text('admin'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginProfPage()),
                      );
                    },
                    child: Text('professeur'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
