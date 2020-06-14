import 'package:flutter/material.dart';
import 'constants.dart';

class DayInfoCard extends StatelessWidget {
  DayInfoCard({this.image, this.day, this.temperature});

  final String day;
  final double temperature;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/button_border.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            day,
            style: kDayOfTheWeekTextStyle,
          ),
          Container(
            height: 50.0,
            child: Image(
              image: AssetImage('images/$image.png'),
            ),
          ),
          Text(
            '${temperature.toInt()}°',
            style: kDayOfTheWeekTextStyle,
          ),
        ],
      ),
    );
  }
}
