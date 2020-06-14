import 'package:flutter/material.dart';
import 'constants.dart';
import 'constants.dart';

class MetricInfoCard extends StatelessWidget {
  MetricInfoCard({this.metric, this.value, this.title});

  final String metric;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                value,
                style: kValueTextStyle,
              ),
              Text(
                metric,
                style: kMetricTextStyle,
              ),
            ],
          ),
          Text(
            title,
            style: kMetricTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
