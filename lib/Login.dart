import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help/HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });

    @override
    void initState() {
      super.initState();
      this.checkAuthentification();
    }
  }

  loginbtn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));

    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // login Image
              Container(
                height: 400,
                child: Image(
                  image: AssetImage("images/login.jpg"),
                  fit: BoxFit.contain,
                ),
              ),

              // TextField
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //  Email textfield
                      Container(
                        child: TextFormField(
                          validator: (String input) {
                            if (input.isEmpty) {
                              return 'Enter Email ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: ' Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input,
                        ),
                      ),

                      // Password Textfield
                      Container(
                        child: TextFormField(
                          validator: (String input) {
                            if (input.length < 6) {
                              return 'Provide Minimum 6 Character';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: ' Password',
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                          onSaved: (input) => _password = input,
                        ),
                      ),

                      // Login button
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed: loginbtn,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: () => navigateToSignUp(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
