import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/appointment/datetimepicker_widget.dart';

class AppointmentPage extends StatefulWidget {
  String docName;
  String specialist;
  String docuid;
  AppointmentPage({Key key, this.docName, this.specialist, this.docuid})
      : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final User user = FirebaseAuth.instance.currentUser;
  void clear() {
    problemc.clear();
  }

  //final patuid = user.uid.toString();
  var problemc = TextEditingController();
  var pro = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Make An Appointment'),
          backgroundColor: Colors.cyan[300]),
      body: Column(children: [
        Card(
            margin: EdgeInsets.all(10),
            color: Colors.cyan[200],
            child: Column(children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Doctor : ' + widget.docName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: Text(
                  'Specialist In : ' + widget.specialist,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: Text('Timings : ' + ' 10 am to 5 pm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ])),
        SizedBox(
          height: 70,
        ),
        TextField(
          maxLines: 5,
          minLines: 1,
          decoration: InputDecoration(
            labelText: 'Enter Your Problem',
          ),
          controller: problemc,
          onChanged: (value) {
            setState(() {
              pro = value;
            });
          },
        ),
        DatetimePickerWidget(
          pro: pro,
          docuid: widget.docuid,
          docname: widget.docName,
          func: clear,
        )
      ]),
    );
  }
}
