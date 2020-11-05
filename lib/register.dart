import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'Models.dart';
import 'listdata.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isvalid = true;
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController genderController =  TextEditingController();
  TextEditingController birthController =  TextEditingController();
  TextEditingController raceController =  TextEditingController();
  TextEditingController zipController =  TextEditingController();
  List<Gender> _genders = Gender.getCompanies();
  List<DropdownMenuItem<Gender>> _dropdownMenuItems;
  List<FirstVoterUser> _firstvoters = FirstVoterUser.getCompanies();
  List<DropdownMenuItem<FirstVoterUser>> _dropdownMenuVoters;
  //get list from model with static data
  List<Politics> _namesparty = Politics.getCompanies();
  List<DropdownMenuItem<Politics>> _dropdownMenuParties;
  List<Eduoption> _degrees = Eduoption.getCompanies();
  List<DropdownMenuItem<Eduoption>> _dropdownMenuDegrees;
  List<Incomecheck> _slots = Incomecheck.getCompanies();
  List<DropdownMenuItem<Incomecheck>> _dropdownMenuSlots;
  DateTime selectedDate = DateTime.now();
  bool _obscureText = true;
  bool _showPassword = false;
  //dropdown values and some model's data
  String dropdownValue = 'Male';
  int selected_item = 0;
  List<String> items = ['Male','Female'];
  Gender _selectedItem;
  FirstVoterUser _selectedType;
  //imported from model class
  Politics _selectedname;
  Eduoption _selectedDegree;
  Incomecheck _selectedslot;
  bool _agreedToTOS = true;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String date = new DateFormat('dd-MM-yyyy').format(selectedDate);
        birthController.text = date;
      });
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
    {
      print('enter email not found');
    }
    // return 'Enter Valid Email';
    else
    {
      print('enter email found');
    }
    // return  null;
  }
  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
  //used mediaquery for divide screen in given ratio.
  Widget _showModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: _showCupertinoDatePicker(),
          );
        }
    );
  }
  Widget _showCupertinoDatePicker() {
    return CupertinoDatePicker(

      initialDateTime: selectedDate,
      onDateTimeChanged: (DateTime newDate) {
        selectedDate = newDate;
        birthController.text = selectedDate.toString();
      },
      mode: CupertinoDatePickerMode.date,
    );
  }
  Widget _buildItemPicker() {
    return CupertinoPicker(
      itemExtent: 60.0,
     // backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (index) {
        setState(() {
          selected_item = index;
        });

      },
      children: new List<Widget>.generate(items.length, (index) {
        return new Center(child:
        Text(items[index]),
        );
      }),
    );
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_genders);
    _dropdownMenuVoters = buildDropdownMenuVoters(_firstvoters);
    _dropdownMenuParties = buildDropdownMenuParties(_namesparty);
    _dropdownMenuDegrees = buildDropdownMenuDegrees(_degrees);
    _dropdownMenuSlots = buildDropdownMenuSlots(_slots);
    super.initState();
  }
  //check is the income comes under <1000 after count
  List<DropdownMenuItem<Incomecheck>> buildDropdownMenuSlots(List companies) {
    List<DropdownMenuItem<Incomecheck>> items = List();
    for (Incomecheck name in companies) {
      items.add(
        DropdownMenuItem(
          value: name,
          child: Text(name.slot),
        ),
      );
    }
    return items;
  }
  List<DropdownMenuItem<Eduoption>> buildDropdownMenuDegrees(List companies) {
    List<DropdownMenuItem<Eduoption>> items = List();
    for (Eduoption name in companies) {
      items.add(
        DropdownMenuItem(
          value: name,
          child: Text(name.name),
        ),
      );
    }
    return items;
  }
  // add political list with items on for loop
  List<DropdownMenuItem<Politics>> buildDropdownMenuParties(List companies) {
    List<DropdownMenuItem<Politics>> items = List();
    for (Politics name in companies) {
      items.add(
        DropdownMenuItem(
          value: name,
          child: Text(name.name),
        ),
      );
    }
    return items;
  }
  List<DropdownMenuItem<FirstVoterUser>> buildDropdownMenuVoters(List companies) {
    List<DropdownMenuItem<FirstVoterUser>> items = List();
    for (FirstVoterUser vote in companies) {
      items.add(
        DropdownMenuItem(
          value: vote,
          child: Text(vote.type),
        ),
      );
    }
    return items;
  }
  List<DropdownMenuItem<Gender>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Gender>> items = List();
    for (Gender gender in companies) {
      items.add(
        DropdownMenuItem(
          value: gender,
          child: Text(gender.gender),

        ),
      );
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body : Container(
         padding: EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.only(top: 10),
         // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                // YourScrollViewWidget(),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    // Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(height: 30,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    "assets/shield.png",
                    height: 110,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: new TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    controller: fnamecontroller,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: new TextField(
                    textAlign: TextAlign.left,
                    controller: lnamecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            new TextField(
              textAlign: TextAlign.left,
                key: _formKey,

              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                // filled: true,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 20),
             new TextField(
              obscureText: !this._showPassword,
              controller: passwordcontroller,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(

              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey),
                 ),
              child:
                  DropdownButtonHideUnderline(

                    child: DropdownButton(

                      hint: Text('Gender'),
                      icon: Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                           // print(value.toString());
                            //genderController.text = _selectedItem.gender;
                          });
                        }),
                  ),
            ),
            SizedBox(height:20),
            new TextField(
              textAlign: TextAlign.left,
              controller: raceController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Add Race',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                // filled: true,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.transparent,
                border: Border.all(color: Colors.grey),
              ),
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text('yes'),
                    icon: Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    value: _selectedType,
                    items: _dropdownMenuVoters,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                        // print(value.toString());
                        //genderController.text = _selectedItem.gender;
                      });
                    }),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:  new TextField(
                    controller: zipController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Zipcode',
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: new TextField(
                    textAlign: TextAlign.center,
                    controller: birthController,
                    // keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Birth date',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    onTap: () {
                      if (Platform.isIOS) {
                        _showModalBottomSheet(context);
                      }
                      if (Platform.isAndroid) {
                        _selectDate(context);
                      }
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.transparent,
                border: Border.all(color: Colors.grey),
              ),
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text('Political Party...'),
                    icon: Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    value: _selectedname,
                    items: _dropdownMenuParties,
                    onChanged: (value) {
                      setState(() {
                        print(_selectedname);
                        _selectedname = value;
                        // print(value.toString());
                        //genderController.text = _selectedItem.gender;
                      });
                    }),
              ),
            ),

            SizedBox(height: 20),
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.transparent,
                border: Border.all(color: Colors.grey),
              ),
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text('Highest level of education'),
                    icon: Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    value: _selectedDegree,
                    items: _dropdownMenuDegrees,
                    onChanged: (value) {
                      setState(() {
                        _selectedDegree = value;
                        // print(value.toString());
                        //genderController.text = _selectedItem.gender;
                      });
                    }),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.transparent,
                border: Border.all(color: Colors.grey),
              ),
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton(
                     hint:Text('Income Level'),
                    icon: Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    value: _selectedslot,
                    items: _dropdownMenuSlots,
                    onChanged: (value) {
                      setState(() {
                        _selectedslot = value;

                        // print(value.toString());
                        //genderController.text = _selectedItem.gender;
                      });
                    }),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children:<Widget> [
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text('I agree to the'),
                ),
                Text('Terms of Service and Disclousures',style: TextStyle(decoration: TextDecoration.underline,),)
              ],
            ),
            // Text('Disclousures',style: TextStyle(decoration: TextDecoration.underline,),),

            // TextFormField(
            //   style: CustomTextStyle.display5(context),
            // //  controller: lnamecontroller,
            //   decoration: Decor.decorText.copyWith(labelText: "Income Level",suffixIcon: IconButton(icon: Icon(Icons.keyboard_arrow_down),),),
            // ),
            SizedBox(height: 20),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              //disabledColor: Colors.grey,
             // disabledTextColor: Colors.black,
              padding: EdgeInsets.all(16.0),
              splashColor: Colors.blueAccent,
              onPressed: ()
              {
                _isvalid = EmailValidator.validate(emailcontroller.text);
                print(_isvalid);
              if (_isvalid)
              {
                if (passwordcontroller.text.length > 0 && fnamecontroller.text.length > 0 && lnamecontroller.text.length > 0 && zipController.text.length > 0 &&
                raceController.text.length > 0 && _genders.length>0 &&_firstvoters.length>0 && _degrees.length>0 )
                {
                  print('right login');
                  getItemAndNavigate(context);
                }
                else
                {
                  Fluttertoast.showToast(
                      msg: 'Enter all fields value',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.transparent,
                      textColor: Colors.blue
                  );
                }
              }
              else
                {
                  Fluttertoast.showToast(
                      msg: 'Enter all fields',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white
                  );
                }
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getItemAndNavigate(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Homedash(
              firstname : fnamecontroller.text,
              lastname : lnamecontroller.text,
              email : emailcontroller.text,
              password : passwordcontroller.text,
              zipcode: zipController.text,
              gender: _selectedItem.gender,
              firstvoter:'yes',
              partyname: _selectedname.name,
              race: raceController.text,
              degree : _selectedDegree.name,
              birthdate: birthController.text,
            ))
    );
  }
 // void showModelBottomSheet({BuildContext context, Container Function(BuildContext context) builder}) {}
}
