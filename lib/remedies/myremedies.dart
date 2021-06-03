import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRemedies extends StatefulWidget {
  MyRemedies({Key key}) : super(key: key);

  @override
  _MyRemediesState createState() => _MyRemediesState();
}

class _MyRemediesState extends State<MyRemedies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Remedies'),
        backgroundColor: Colors.cyan[300],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  'patients/${FirebaseAuth.instance.currentUser.uid.toString()}/remedies')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            final documents = streamSnapshot.data.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) => InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: Colors.red[50],
                                content: Card(
                                  elevation: null,
                                  shadowColor: null,
                                  color: Colors.cyan[50],
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text('Remedy Name : ' +
                                              documents[index]['remname'])),
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text('Ingredients : ' +
                                              documents[index]['ing'])),
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text('Description : ' +
                                              documents[index]['desc'])),
                                    ],
                                  ),
                                ));
                          });
                    },
                    child: Card(
                      margin: EdgeInsets.all(20),
                      color: Colors.cyan[300],
                      child: Container(
                          padding: EdgeInsets.all(10),
                          width: 200.00,
                          alignment: Alignment.center,
                          child: Text(
                            documents[index]['remname'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    )));
          }),
    );
  }
}
