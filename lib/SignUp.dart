import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help/HomePage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });

    @override
    void initState() {
      super.initState();
      this.checkAuthentication();
    }
  }

  signUpbtn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          // user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _name);
        }
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
                      // User Name
                      Container(
                        child: TextFormField(
                          validator: (String input) {
                            if (input.isEmpty) {
                              return 'Enter Full Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: ' Full Name',
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (input) => _name = input,
                        ),
                      ),

                      //  Email textfield
                      Container(
                        child: TextFormField(
                          validator: (String input) {
                            if (input.isEmpty) {
                              return 'Enter Email';
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
                          onPressed: signUpbtn,
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
