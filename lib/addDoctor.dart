import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDoctor extends StatelessWidget {
//   AddDoctor({Key key}) : super(key: key);

//   @override
//   _AddDoctorState createState() => _AddDoctorState();
// }

// class _AddDoctorState extends State<AddDoctor> {
  final _formKey = GlobalKey<FormState>();
  final namec = TextEditingController();
  final speclistc = TextEditingController();
  final phonec = TextEditingController();
  final mapc = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red[300],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 6)
                          return 'Please return a valid value';
                      },
                      controller: namec,
                      decoration: InputDecoration(labelText: 'Name Of Doctor'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: speclistc,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 4)
                          return 'Please return a valid value';
                      },
                      decoration: InputDecoration(labelText: 'Specialist In'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailc,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 6 || !val.contains('@'))
                          return 'Please return a valid value';
                      },
                      decoration: InputDecoration(labelText: 'Email Id'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phonec,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 6)
                          return 'Please return a valid value';
                      },
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mapc,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 6)
                          return 'Please return a valid value';
                      },
                      decoration:
                          InputDecoration(labelText: 'Clinic G-Map Link'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passc,
                      obscureText: true,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty || val.length < 6)
                          return 'Please return a valid value';
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                      child: Text(
                        "Register",
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var i = 1;
                          _formKey.currentState.save();
                          print('done doctor uploading');
                          // ignore: unused_local_variable
                          UserCredential authResult;
                          try {
                            authResult = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailc.text.trim(),
                                    password: passc.text.trim());
                          } catch (err) {
                            if (err.message != null) {
                              print(err.message);
                              i = 0;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(err.message),
                                    );
                                  });
                            }
                          }
                          if (i != 0) {
                            final User user = FirebaseAuth.instance.currentUser;
                            final uid = user.uid.toString();
                            FirebaseFirestore.instance
                                .collection('doctors')
                                .doc(uid)
                                .set({
                              'name': namec.text.trim(),
                              'specialist': speclistc.text.trim(),
                              'number': phonec.text.trim(),
                              'email': emailc.text.trim(),
                              'maps': mapc.text.trim(),
                              'password': passc.text.trim(),
                              'uid': uid
                            });
                            print('bldfsdf');
                            namec.clear();
                            speclistc.clear();
                            phonec.clear();
                            emailc.clear();
                            mapc.clear();
                            passc.clear();
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
