import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DocNearMe extends StatelessWidget {
  final abc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Near Me'),
        backgroundColor: Colors.cyan[300],
      ),
      backgroundColor: Colors.red[50],
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 150,
        ),
        TextField(
            decoration: InputDecoration(
                labelText: 'Enter The Type Of Doctor You Are Looking For'),
            controller: abc),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: () {
              (abc.text.trim() != null)
                  ? MapsLauncher.launchQuery(abc.text)
                  : null;
            },
            child: Text('Submit'))
      ]),
    );
  }
}
