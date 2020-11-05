import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'register.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:age/age.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  home: Homedash(),
));



class Homedash extends StatefulWidget {
  final firstname;
  final lastname;
  final password;
  final email;
  final gender;
  // String birthdate;
  final firstvoter;
  final partyname;
  final zipcode;
  final race;
  final degree;
  final birthdate;
  // String income;
  Homedash({
    Key key, @required this.firstname,this.lastname,this.email,this.zipcode,this.password,this.firstvoter,this.partyname,this.gender,this.race,this.degree,this.birthdate}) : super(key: key);

  @override
  _HomedashState createState() => _HomedashState();
}

class _HomedashState extends State<Homedash> {
  String _locationMessage ="";
  Position _currentPosition;
  String _currentAddress;
  String _agecal;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
  bool isAdult(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;
    String agestr = "$yearDiff";
    _agecal = agestr;
    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }

  @override
  void initState() {
    super.initState();
   _getCurrentLocation();
    isAdult(widget.birthdate);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
    // mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
       SizedBox(
           height: 40,
       ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('first name : ${widget.firstname}',style:ThemeText.custom_style.copyWith(fontSize: 20),),

          ),
          SizedBox(
            height: 14,
          ),
          Container(
            child: Text('last name : ${widget.lastname}',style: ThemeText.custom_style.copyWith(fontSize: 20),)),
          SizedBox(
            height: 14,
          ),
          Container(
            child: Text('password : ${widget.password}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            child: Text('email : ${widget.email}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            child: Text('zip : ${widget.zipcode}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
          ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: Text('gender : ${widget.gender}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: Text('Party name : ${widget.partyname}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: Text('first voter: ${widget.firstvoter}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: Text('race: ${widget.race}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        SizedBox(
          height: 19,
        ),
        Container(
          child: Text('Degree: ${widget.degree}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        SizedBox(
          height: 19,
        ),
        Row(
          children: [
            Container(

              child: Text('Address: ${_currentAddress}',style: ThemeText.custom_style.copyWith(fontSize: 18),maxLines: 3),
            ),
          ],
        ),
        SizedBox(
          height: 19,
        ),
        Container(
          child: Text('Age: ${_agecal} Year',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        ]
          ),
        )
    );
  }
}