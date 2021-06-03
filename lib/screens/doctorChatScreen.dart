import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/docNewMessage.dart';
import 'package:bubble/bubble.dart';

class DocChatScreen extends StatefulWidget {
  String patName;
  String uid;
  DocChatScreen({this.patName, this.uid});

  @override
  _DocChatScreenState createState() => _DocChatScreenState();
}

class _DocChatScreenState extends State<DocChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Patient Name: ${widget.patName}'),
          backgroundColor: Colors.red[300],
        ),
        backgroundColor: Colors.cyan[50],
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(
                            'doctors/${FirebaseAuth.instance.currentUser.uid.toString()}/patients/${widget.uid}/chats')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (ctx, chatSnapshot) {
                      if (chatSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final chatdocs = chatSnapshot.data.docs;
                      final User user = FirebaseAuth.instance.currentUser;
                      final currentuid = user.uid.toString();
                      return ListView.builder(
                          reverse: true,
                          itemCount: chatdocs.length,
                          itemBuilder: (ctx, index) => chat(
                              chatdocs[index]['text'],
                              currentuid,
                              chatdocs[index]['senderuid'])
                          // Expanded(
                          //     child:
                          //     Row(
                          //         mainAxisAlignment:
                          //             currentuid == chatdocs[index]['senderuid']
                          //                 ? MainAxisAlignment.end
                          //                 : MainAxisAlignment.start,
                          //         children: [Text(chatdocs[index]['text'])]))
                          );
                    })),
            DocNewMessage(uid: widget.uid)
          ],
        ));
  }

  Widget chat(String message, String currentuid, String senderuid) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: currentuid == senderuid ? Colors.pink[100] : Colors.cyan[200],
          elevation: 0.0,
          alignment: !(currentuid == senderuid)
              ? Alignment.topLeft
              : Alignment.topRight,
          nip: !(currentuid == senderuid)
              ? BubbleNip.leftBottom
              : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(currentuid == senderuid
                      ? "assets/doctor.png"
                      : "assets/user.png"),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Color.fromRGBO(14, 49, 80, 1),
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
    );
  }
}
