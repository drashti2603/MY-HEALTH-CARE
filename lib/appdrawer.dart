import 'package:flutter/material.dart';
import 'package:my_first_app/remedies/addRemedy.dart';
import 'package:my_first_app/remedies/myremedies.dart';
import 'package:my_first_app/screens/ourTeam.dart';
import './remedies/remedyPage.dart';

class CustomDrawer extends StatelessWidget {
  BuildContext context;
  CustomDrawer(var context);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Image.asset(
                  "assets/logo.png",
                  width: 137,
                  height: 137,
                ))
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.cyan[300],
            ),
          ),
          ListTile(
            title: Text('Home Remedies'),
            onTap: () {
              print('Home Remedies pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RemedyPage();
              }));
            },
          ),
          ListTile(
            title: Text('My Remedies'),
            onTap: () {
              print('My Remedies pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return MyRemedies();
              }));
            },
          ),
          ListTile(
            title: Text('Add Own Remedies'),
            onTap: () {
              print('Add Own Remedies pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return AddRemedy();
              }));
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              print('About Us pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return OurTeam();
              }));
            },
          ),
        ],
      ),
    );
  }
}
