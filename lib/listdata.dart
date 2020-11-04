import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'register.dart';
import 'constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_availability/google_api_availability.dart';

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
  // String income;
  Homedash({
    Key key, @required this.firstname,this.lastname,this.email,this.zipcode,this.password,this.firstvoter,this.partyname,this.gender,this.race,this.degree}) : super(key: key);

  @override
  _HomedashState createState() => _HomedashState();
}

class _HomedashState extends State<Homedash> {
  String _locationMessage ="";
  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });

  }
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

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
          height: 14,
        ),
        Container(
          child: Text('Degree: ${widget.degree}',style: ThemeText.custom_style.copyWith(fontSize: 20),),
        ),
        ]
          ),
        )

    );
  }
}