import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/screens/doctorChatScreen.dart';

class DocAppointmentScreen extends StatefulWidget {
  DocAppointmentScreen({Key key}) : super(key: key);

  @override
  _DocAppointmentScreenState createState() => _DocAppointmentScreenState();
}

class _DocAppointmentScreenState extends State<DocAppointmentScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Appointment List'),
          backgroundColor: Colors.red[300],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    'doctors/${FirebaseAuth.instance.currentUser.uid.toString()}/appointments')
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              final documents = streamSnapshot.data.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) => Center(
                          child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Name : ' +
                                              documents[index]['name'])),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Contact Number : ' +
                                              documents[index]['number'])),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Email Id : ' +
                                              documents[index]['email'])),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Date : ' +
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime.fromMicrosecondsSinceEpoch(
                                                      documents[index]['date']
                                                          .microsecondsSinceEpoch)))),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Time : ' +
                                              DateFormat('HH : mm').format(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      documents[index]['date']
                                                          .microsecondsSinceEpoch)))),
                                      //
                                      //
                                      // DateTime.fromMicrosecondsSinceEpoch(documents[index]['date'].microsecondsSinceEpoch)
                                      //
                                      //
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Problem Description : ' +
                                              documents[index]['problem'])),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red[300]),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return DocChatScreen(
                                                    patName: documents[index]
                                                        ['name'],
                                                    uid: documents[index]
                                                        ['patientuid'],
                                                  );
                                                }));
                                              },
                                              child: Text('Chat'))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              });
                        },
                        child: Card(
                          margin: EdgeInsets.all(20),
                          color: Colors.red[300],
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: 200.00,
                              alignment: Alignment.center,
                              child: Text(
                                documents[index]['name'],
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )));
            }));
  }
}
