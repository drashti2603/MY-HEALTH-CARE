import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/screens/Appointment/appointmentPage.dart';
import 'package:my_first_app/screens/patientChatScreen.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Of Doctors'),
          backgroundColor: Colors.cyan[300],
        ),
        backgroundColor: Colors.red[50],
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('doctors').snapshots(),
            builder: (ctx, streamSnapshot) {
              final documents = streamSnapshot.data.docs;
              return ListView.builder(
                  itemCount: documents.length,
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
                                              child: Text('Name : ' +
                                                  documents[index]['name'])),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Specialist In : ' +
                                                  documents[index]
                                                      ['specialist'])),
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
                                              child: InkWell(
                                                  highlightColor: Colors.amber,
                                                  onTap: () =>
                                                      MapsLauncher.launchQuery(
                                                          documents[index]
                                                              ['maps']),
                                                  child: Text(
                                                    'Clinic Location Link : ' +
                                                        documents[index]
                                                            ['maps'],
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.cyan[300]),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return ChatScreen(
                                                        docName:
                                                            documents[index]
                                                                ['name'],
                                                        uid: documents[index]
                                                            ['uid'],
                                                      );
                                                    }));
                                                  },
                                                  child: Text('Chat')),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.cyan[300]),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return AppointmentPage(
                                                        docName:
                                                            documents[index]
                                                                ['name'],
                                                        specialist:
                                                            documents[index]
                                                                ['specialist'],
                                                        docuid: documents[index]
                                                            ['uid'],
                                                      );
                                                    }));
                                                  },
                                                  child: Text(
                                                      'Make An Appointment')),
                                            ],
                                          )
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
                                documents[index]['name'],
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )));
            }));
  }
}
