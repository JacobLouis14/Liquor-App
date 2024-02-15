import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/////////////////////////////File Import
import 'package:frontend/screens/splash/introScreen3.dart';
import 'package:frontend/screens/splash/introMainScreen.dart';

class IntroScreen_2 extends StatefulWidget {
  final PageController controller;

  IntroScreen_2({required this.controller});

  @override
  State<IntroScreen_2> createState() => _IntroScreen_2State();
}

class _IntroScreen_2State extends State<IntroScreen_2> {
  TextEditingController _dateInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  //Date of Birth Handler
  void dobHandler(DateTime dateValue) {
    String formattedDate = DateFormat("dd-MM-yyyy").format(dateValue);
    DateTime currentDate = DateTime.now();
    setState(() {
      _dateInputController.text = formattedDate;
    });
    int age = currentDate.year - dateValue.year;
    int cMonth = currentDate.month;
    int bMonth = dateValue.month;
    if (bMonth > cMonth) {
      age--;
    } else if (bMonth == cMonth) {
      int cday = currentDate.day;
      int bday = dateValue.day;
      if (bday > cday) {
        age--;
      }
    }
    if (age >= 18) {
      setState(() {
        isLegal.value = true;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => IntroScreen_3()));
      });
    } else {
      setState(() {
        isLegal.value = false;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => IntroScreen_3()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 140,
          ),
          const Text(
            "Are you Legal to drinks ?.Let's Checkout",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 3,
                fontFamily: "Italiano",
                fontSize: 40,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          TextField(
            controller: _dateInputController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
                icon: Icon(Icons.calendar_today),
                labelText: "Enter Date of Birth"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                dobHandler(pickedDate);
                setState(() {
                  isEngaged.value = true;
                });
              } else {
                setState(() {
                  _dateInputController.text = "Date not Selected";
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
