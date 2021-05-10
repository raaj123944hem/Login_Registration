import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 45.0),
            Container(
              height: 300,
              child: Image(
                image: AssetImage("images/start.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                  text: 'Welcome To',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Codex',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange))
                  ]),
            ),
            SizedBox(height: 10.0),
            Text(
              'Code For fun Right Now',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Login Button here
                ElevatedButton(
                  // padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  onPressed: navigateToLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                // Register button here
                ElevatedButton(
                  onPressed: navigateToRegister,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
            SizedBox(height: 20.0),

            // SignUp google Button
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
