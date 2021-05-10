import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "Start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    this.checkAuthentification();
    this.getUser();
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SizedBox(height: 30.0),
                  Container(
                    height: 400,
                    child: Image(
                      image: AssetImage("images/welcome.jpg"),
                    ),
                  ),
                  Container(
                    child: Text(
                        "Hello ${user.displayName}  you are Logged in as ${user.email}",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                      onPressed: signOut,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
      ),
    );
  }
}
