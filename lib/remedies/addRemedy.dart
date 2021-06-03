import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddRemedy extends StatefulWidget {
  AddRemedy({Key key}) : super(key: key);

  @override
  _AddRemedyState createState() => _AddRemedyState();
}

class _AddRemedyState extends State<AddRemedy> {
  final a = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final b = TextEditingController();
  final c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Own Remedies'),
        backgroundColor: Colors.cyan[300],
      ),
      backgroundColor: Colors.red[50],
      body: Center(
        child: SingleChildScrollView(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                margin: EdgeInsets.all(20),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'Please return a valid value';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter Remedy Name',
                                ),
                                controller: a,
                              )),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'Please return a valid value';
                                },
                                maxLines: 2,
                                minLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'Enter Ingredients',
                                ),
                                controller: b,
                              )),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'Please return a valid value';
                                },
                                maxLines: 5,
                                minLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                ),
                                controller: c,
                              )),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.cyan[300]),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      FirebaseFirestore.instance
                                          .collection(
                                              'patients/${FirebaseAuth.instance.currentUser.uid.toString()}/remedies')
                                          .add({
                                        'remname': a.text.trim(),
                                        'ing': b.text.trim(),
                                        'desc': c.text.trim()
                                      });
                                      a.clear();
                                      b.clear();
                                      c.clear();
                                    }
                                  },
                                  child: Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Text('Add'))))
                        ]))))),
      ),
    );
  }
}
