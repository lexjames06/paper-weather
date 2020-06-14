import 'package:flutter/material.dart';
import 'constants.dart';

class SunInfoCard extends StatelessWidget {
  SunInfoCard({this.image, this.sunMovement, this.time});

  final String sunMovement;
  final String time;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 80.0,
            child: Image(
              image: AssetImage('images/$image.png'),
            ),
          ),
          Text(
            sunMovement,
            style: kSunMovementTextStyle,
          ),
          Text(
            time,
            style: kSunMovementTimeTextStyle,
          ),
        ],
      ),
    );
  }
}
