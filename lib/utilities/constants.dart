import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 100.0,
  height: 1,
  color: Colors.black,
);

const kCityNameTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 40.0,
  color: Colors.black,
);

const kSunMovementTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 30.0,
  color: Colors.black,
);

const kDayOfTheWeekTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 30.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kMetricTitleTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 25.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kMetricTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kValueTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 40.0,
  color: Colors.black,
);

const kSunMovementTimeTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 30.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 60.0,
  color: Colors.black,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Amatic SC',
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kConditionTextStyle = TextStyle(
  fontSize: 50.0,
  height: 1.4,
);

const kTextFieldInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  filled: true,
  icon: Image(
    image: AssetImage('images/search.png'),
    height: 30.0,
  ),
  hintText: 'City Name...',
  hintStyle: TextStyle(
    fontSize: 30.0,
    color: Colors.black,
    fontFamily: 'Amatic SC',
  ),
);
