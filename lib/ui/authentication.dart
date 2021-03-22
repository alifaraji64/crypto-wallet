import 'package:flutter/material.dart';
import 'package:test_app/net/flutterfire.dart';

import 'home_view.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  @override
  bool get mounted => super.mounted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: _emailField,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              TextFormField(
                controller: _passwordField,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white),
                  child: MaterialButton(
                    onPressed: () {
                      register(_emailField.text, _passwordField.text)
                          .then((result) => {
                                if (!result)
                                  {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        '$error',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.amber,
                                    ))
                                  }
                                else
                                  {
                                    //registeration was successfull
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    )
                                  }
                              })
                          .catchError((e) => {print('error occured')});
                    },
                    child: Text("Register"),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white),
                  child: MaterialButton(
                    onPressed: () async {
                      signIn(_emailField.text, _passwordField.text)
                          .then((result) => {
                                if (!result)
                                  {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        '$error',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.amber,
                                    ))
                                  }
                                else
                                  {
                                    //login was successfull
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    )
                                  }
                              })
                          .catchError((e) => {print('error occured')});
                    },
                    child: Text("Login"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
