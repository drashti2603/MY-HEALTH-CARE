import 'package:flutter/material.dart';
import 'package:my_first_app/screens/DoctorList.dart';
import 'package:my_first_app/screens/medicalhistory.dart';
import 'package:url_launcher/url_launcher.dart';
import './DocNearMe.dart';
import '../appdrawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  cov19info() async {
    const url =
        'https://www.who.int/westernpacific/emergencies/covid-19/news-covid-19';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true); //forceWebView
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('My Heath Care '),
        backgroundColor: Colors.cyan[300],
      ),
      drawer: CustomDrawer(context),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            width: 15,
            height: 50,
          ),
          CarouselSlider(
              //height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 3000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {});
              },
              items: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img1.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img2.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img3.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img4.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img5.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/Images/img7.jpg'),
                        fit: BoxFit.cover,
                      )),
                )
              ]),
          SizedBox(
            width: 15,
            height: 50,
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
          //   onPressed: () => print('Appointment pressed'),
          //   child: Container(
          //       width: 150.00,
          //       alignment: Alignment.center,
          //       child: Text('Make An Appointment')),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: () {
              print('Chatbot pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return DoctorList();
              }));
            },
            child: Container(
                width: 150.00,
                alignment: Alignment.center,
                child: Text('Doctors ')),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: () {
              print('docs near me pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return DocNearMe();
              }));
            },
            child: Container(
                width: 150.00,
                alignment: Alignment.center,
                child: Text('Doctors Near Me')),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: () {
              print('Covid pressed');
              cov19info();
            },
            child: Container(
                width: 150.00,
                alignment: Alignment.center,
                child: Text('COVID-19 Info')),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.cyan[300]),
            onPressed: () {
              print('Medical History pressed');
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return MedicalHistroy();
              }));
            },
            child: Container(
                width: 150.00,
                alignment: Alignment.center,
                child: Text('My Medical History')),
          ),
        ],
      )),
    );
  }
}
