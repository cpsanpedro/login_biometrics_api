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
        onPressed: () async {
          //retrieve the saved pincode
          String _retrievedPin = await FlutterLocker.retrieve(RetrieveSecretRequest(key, AndroidPrompt("Login with Fingerprint", "Cancel"), IOsPrompt("Login with Fingerprint")));
          //fetch correct pincode from API
          String _pinFromApi = await Api().fetchData();
          //compare the pincode saved from biometrics with API
          if (_retrievedPin == _pinFromApi) {
            print("Success Login from biometrics");
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()));
          }

        },
        child: Text("Login with Biometrics"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Biometrics Login API"),),
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
                  //to check if the pin is same from the backend
                  if (_pincode == _pin) {
                    //save the pincode so that, next time we can retrieve it
                    await FlutterLocker.save(SaveSecretRequest(
                        key, _pincode, AndroidPrompt("Authenticate", "Cancel")));
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
