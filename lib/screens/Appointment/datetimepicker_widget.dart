import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimePickerWidget extends StatefulWidget {
  String docuid;
  String pro;
  String docname;
  Function func;
  DatetimePickerWidget({this.pro, this.docname, this.docuid, this.func});
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  DateTime dateTime;

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
          child: Text(getText()),
          onPressed: () => pickDateTime(context),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: submit,
            child: Text('Submit'))
      ]);

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void submit() {
    final User user = FirebaseAuth.instance.currentUser;
    final patientuid = user.uid.toString();
    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientuid)
        .get()
        .then((data) {
      var name = data.data()['name'];
      var email = data.data()['email'];
      var number = data.data()['number'];
      print('this is ' + widget.pro);
      FirebaseFirestore.instance
          .collection('patients/${patientuid}/diseases')
          .add({
        'problem': widget.pro,
        'date': dateTime,
        'docname': widget.docname
      });
      FirebaseFirestore.instance
          .collection('doctors/${widget.docuid}/appointments')
          .doc(patientuid)
          .set({
        'problem': widget.pro,
        'patientuid': patientuid,
        'name': name,
        'number': number,
        'email': email,
        'date': dateTime,
      });
    });
    // FirebaseFirestore.instance
    //     .collection('/doctors/${widget.docuid}/appointments')
    //     .doc(patientuid)
    //     .set({'desc': widget.problem.text.trim(), 'date': dateTime});
    widget.func();
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
