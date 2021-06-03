import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/DocHomePage.dart';
import 'package:my_first_app/screens/HomePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var emailc = TextEditingController();
  var passc = TextEditingController();
  bool isPatient = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        backgroundColor: isPatient ? Colors.cyan[300] : Colors.red[300],
      ),
      backgroundColor: isPatient ? Colors.cyan[100] : Colors.red[100],
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailc,
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty || val.length < 4)
                            return 'Please return a valid value';
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passc,
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty || val.length < 4)
                            return 'Please return a valid value';
                        },
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text('Log In As Doctor'),
                          Switch(
                            value: isPatient,
                            onChanged: (value) {
                              setState(() {
                                isPatient = value;
                                print(isPatient);
                              });
                            },
                            activeTrackColor: Colors.cyan[200],
                            activeColor: Colors.cyan[300],
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.red,
                          ),
                          Text('Log In As Patient'),
                        ])),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: isPatient
                                    ? Colors.cyan[300]
                                    : Colors.red[300]),
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailc.text.trim(),
                                      password: passc.text.trim())
                                  .then((result) {
                                if (isPatient) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    //MaterialPageRoute(builder: (context) => Homepage()),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DocHomePage()),
                                    //MaterialPageRoute(builder: (context) => Homepage()),
                                  );
                                }
                              }).catchError((err) {
                                if (err.message != null) {
                                  print(err.message);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Error"),
                                          content: Text(err.message),
                                        );
                                      });
                                }
                              });
                            },
                            //onPressed: () async {
                            // if (_formKey.currentState.validate()) {
                            //   _formKey.currentState.save();

                            //   UserCredential authResult;
                            //   try {
                            //     authResult = await FirebaseAuth.instance
                            //         .signInWithEmailAndPassword(
                            //             email: emailc.text.trim(),
                            //             password: passc.text.trim());
                            //   } catch (err) {
                            //     if (err.message != null) {
                            //       print(err.message);
                            //       showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               title: Text("Error"),
                            //               content: Text(err.message),
                            //             );
                            //           });
                            //     }
                            //   }
                            // }
                            //
                            //
                            //   Navigator.of(context)
                            //       .push(MaterialPageRoute(builder: (_) {
                            //     return HomePage();
                            //   }));
                            // },
                            child: Text(
                              "Log In",
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
