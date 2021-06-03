import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  String uid;
  NewMessage({Key key, this.uid}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  void sendMessage() {
    FocusScope.of(context).unfocus();
    messagec.clear();
    final User user = FirebaseAuth.instance.currentUser;
    final patientuid = user.uid.toString();
    FirebaseFirestore.instance
        .collection('doctors/${widget.uid}/patients/$patientuid/chats')
        .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'senderuid': patientuid
    });

    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientuid)
        .get()
        .then((data) {
      var name = data.data()['name'];
      var email = data.data()['email'];
      var number = data.data()['number'];
      FirebaseFirestore.instance
          .collection('doctors/${widget.uid}/patients')
          .doc(patientuid)
          .set({
        'patientuid': patientuid,
        'name': name,
        'number': number,
        'email': email,
      });
    });
  }

  var messagec = TextEditingController();
  var enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: messagec,
            decoration: InputDecoration(labelText: 'Send a Message...'),
            onChanged: (value) {
              setState(() {
                enteredMessage = value;
              });
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: enteredMessage.trim().isEmpty ? null : sendMessage)
        ],
      ),
    );
  }
}
