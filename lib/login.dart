import 'package:app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emaillog = TextEditingController();
  TextEditingController passwordlog = TextEditingController();
  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  login(BuildContext context, String email, String password) async {
    if (email == '' && password == '') {
      return _showAlertDialog(
          context, "error", 'please enter email and password');
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          _showAlertDialog(context, 'success', 'successfully loggedIn');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        return _showAlertDialog(context, 'error', ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'lib/asset/login.png',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Handle back button press
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emaillog,
                    decoration: InputDecoration(
                      labelText: 'Email*',
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordlog,
                    decoration: InputDecoration(
                      labelText: 'Password*',
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.push(context,
                      //  MaterialPageRoute(builder: (context) => Home()));
                      login(
                          context, emaillog.toString(), passwordlog.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 228, 225, 225),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('LOGIN'),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    width: double.infinity,
                    height: 250,
                    child: Image.asset('lib/assets/car5.png'),
                    // Replace with your asset image path
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    ' WELCOME TO ANYTIME CAR',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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