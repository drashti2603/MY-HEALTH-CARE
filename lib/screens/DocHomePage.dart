import 'package:flutter/material.dart';
import 'Appointment/docappointmentscreen.dart';
import './PatientList.dart';

class DocHomePage extends StatelessWidget {
  const DocHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctor Home Page'),
          backgroundColor: Colors.red[300],
        ),
        backgroundColor: Colors.cyan[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return DocAppointmentScreen();
                      })),
                  child: Container(
                      width: 200.00,
                      height: 40.00,
                      alignment: Alignment.center,
                      child: Text('Check Appointments'))),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return PatientList();
                    }));
                  },
                  child: Container(
                      width: 200.00,
                      height: 40.00,
                      alignment: Alignment.center,
                      child: Text('Chat With Patients')))
            ],
          ),
        ));
  }
}
