import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DocNewMessage extends StatefulWidget {
  String uid;
  DocNewMessage({Key key, this.uid}) : super(key: key);

  @override
  _DocNewMessageState createState() => _DocNewMessageState();
}

class _DocNewMessageState extends State<DocNewMessage> {
  void sendMessage() {
    FocusScope.of(context).unfocus();
    messagec.clear();
    final User user = FirebaseAuth.instance.currentUser;
    final doctoruid = user.uid.toString();
    FirebaseFirestore.instance
        .collection('doctors/$doctoruid/patients/${widget.uid}/chats')
        .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'senderuid': doctoruid
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
