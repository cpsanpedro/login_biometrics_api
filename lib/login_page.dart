import 'package:flutter/material.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:locker/api.dart';
import 'package:locker/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pincode = "";
  String key = "pwdkey";

  Widget _biometricsLogin() {
    return ElevatedButton(
        onPressed: () {
          FlutterLocker.save(SaveSecretRequest(
              key, _pincode, AndroidPrompt("Authenticate", "Cancel")));
        },
        child: Text("Login with Biometrics"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                _pincode = val;
              },
            ),
            TextButton(
                onPressed: () async {
                  String _pin = await Api().fetchData();
                  if (_pincode == _pin) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                    print("Success!");
                  }
                },
                child: Text("Login")),
            _biometricsLogin(),
          ],
        ),
      ),
    );
  }
}
