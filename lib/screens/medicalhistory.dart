import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalHistroy extends StatelessWidget {
  const MedicalHistroy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Medical History'),
          backgroundColor: Colors.cyan[300],
        ),
        backgroundColor: Colors.red[50],
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    'patients/${FirebaseAuth.instance.currentUser.uid.toString()}/diseases')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              final diseases = streamSnapshot.data.docs;
              return ListView.builder(
                  itemCount: diseases.length,
                  itemBuilder: (ctx, index) => Center(
                          child: InkWell(
                        highlightColor: Colors.red[100],
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    backgroundColor: Colors.cyan[50],
                                    content: Card(
                                      elevation: null,
                                      shadowColor: null,
                                      color: Colors.red[50],
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Name Of Doctor: ' +
                                                  diseases[index]['docname'])),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Date :  ' +
                                                  DateFormat('EEE, d/M/y')
                                                      .format(DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                              diseases[index]
                                                                      ['date']
                                                                  .microsecondsSinceEpoch)))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Probelm : ' +
                                                  diseases[index]['problem'])),
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
                                diseases[index]['docname'],
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )));
            }));
  }
}
