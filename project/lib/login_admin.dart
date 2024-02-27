import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/espace_admin.dart';
import 'dart:convert';
class LoginAdminPage extends StatefulWidget {
  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Send username and password to PHP file
    var url = Uri.parse('http://192.168.11.103/flutter/api/login_admin.php'); // Updated code
    var response = await http.post(url, body: {'email': email, 'password': password});
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Handle response from PHP file
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('id_user')) {
          //int id = jsonResponse['id'];
          // Login successful, navigate to the next page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EspaceAdminPage(user_data : jsonResponse)),
          );
        } else {
          // Login failed, show an error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Invalid username or password.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Invalid response format
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Unexpected response format.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle server error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Server error. Please try again later.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
