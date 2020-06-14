import 'dart:developer';

import 'package:clima/utilities/day_info_card.dart';
import 'package:clima/utilities/metrics_info_card.dart';
import 'package:clima/utilities/sun_info_card.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({this.locationWeather, this.forecastWeather});

  final locationWeather;
  final forecastWeather;

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  WeatherModel weather = WeatherModel();

  DateTime sunsetTime;
  DateTime sunriseTime;
  double maxTemp;
  double minTemp;
  int humidity;
  double windSpeed;
  String day0;
  String day1;
  String day2;
  String day3;
  String day4;
  String day0Image;
  String day1Image;
  String day2Image;
  String day3Image;
  String day4Image;
  double day0Temp;
  double day1Temp;
  double day2Temp;
  double day3Temp;
  double day4Temp;
  String sunriseTimeOfDay;
  String sunsetTimeOfDay;

  var time = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.forecastWeather);
//    findForecastDataPoints(widget.locationWeather, widget.forecastWeather);
  }

  void updateUI(dynamic weatherData, dynamic fiveDayForeCast) {
    setState(() {
      if (weatherData == null || fiveDayForeCast == null) {
        sunsetTime = null;
        sunriseTime = null;
        maxTemp = null;
        minTemp = null;
        humidity = null;
        windSpeed = null;
        day0 = '';
        day1 = '';
        day2 = '';
        day3 = '';
        day4 = '';
        day0Image = '';
        day1Image = '';
        day2Image = '';
        day3Image = '';
        day4Image = '';
        day0Temp = null;
        day1Temp = null;
        day2Temp = null;
        day3Temp = null;
        day4Temp = null;
        return;
      }
      sunsetTime = DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunset'] * 1000);
      sunriseTime = DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunrise'] * 1000);
      maxTemp = weatherData['main']['temp_max'];
      minTemp = weatherData['main']['temp_min'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      var currentTime = DateTime.now();
      day0 = weather.getDayOfTheWeek(currentTime.weekday);
      day1 = weather.getDayOfTheWeek(currentTime.weekday + 1);
      day2 = weather.getDayOfTheWeek(currentTime.weekday + 2);
      day3 = weather.getDayOfTheWeek(currentTime.weekday + 3);
      day4 = weather.getDayOfTheWeek(currentTime.weekday + 4);
      var hour = currentTime.hour;
      var weatherImageIndex = weather.getWeatherIndex(hour);
      day0Image = weather.getWeatherIcon(
          fiveDayForeCast['list'][weatherImageIndex]['weather'][0]['id'], true);
      day1Image = weather.getWeatherIcon(
          fiveDayForeCast['list'][weatherImageIndex + 8]['weather'][0]['id'],
          true);
      day2Image = weather.getWeatherIcon(
          fiveDayForeCast['list'][weatherImageIndex + 16]['weather'][0]['id'],
          true);
      day3Image = weather.getWeatherIcon(
          fiveDayForeCast['list'][weatherImageIndex + 24]['weather'][0]['id'],
          true);
      day4Image = weather.getWeatherIcon(
          fiveDayForeCast['list'][weatherImageIndex + 32]['weather'][0]['id'],
          true);
      day0Temp = fiveDayForeCast['list'][weatherImageIndex]['main']['temp'];
      day1Temp = fiveDayForeCast['list'][weatherImageIndex + 8]['main']['temp'];
      day2Temp =
          fiveDayForeCast['list'][weatherImageIndex + 16]['main']['temp'];
      day3Temp =
          fiveDayForeCast['list'][weatherImageIndex + 24]['main']['temp'];
      day4Temp =
          fiveDayForeCast['list'][weatherImageIndex + 32]['main']['temp'];
    });
  }

  void findForecastDataPoints(dynamic weatherData, dynamic forecastWeather) {
    print(forecastWeather['list'][0]['dt']);
    print(weatherData['sys']['sunset']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Image(
                      image: AssetImage('images/back.png'),
                      height: 30.0,
                    ),
                  ),
                ),
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/sunrise_border.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.dstATop),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SunInfoCard(
                        time: '${sunriseTime.hour}:${sunriseTime.minute}am',
                        sunMovement: 'SUNRISE',
                        image: 'sunrise',
                      ),
                      SunInfoCard(
                        time: '${sunsetTime.hour - 12}:${sunsetTime.minute}pm',
                        sunMovement: 'SUNSET',
                        image: 'sunset',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MetricInfoCard(
                        title: 'HIGH',
                        value: '$maxTemp°',
                        metric: '',
                      ),
                      MetricInfoCard(
                        title: 'LOW',
                        value: '$minTemp°',
                        metric: '',
                      ),
                      MetricInfoCard(
                        title: 'HUMIDITY',
                        value: '$humidity',
                        metric: '%',
                      ),
                      MetricInfoCard(
                        title: 'WIND SPEED',
                        value: '$windSpeed',
                        metric: 'm/s',
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DayInfoCard(
                        image: day0Image,
                        day: day0,
                        temperature: day0Temp,
                      ),
                      DayInfoCard(
                        image: day1Image,
                        day: day1,
                        temperature: day1Temp,
                      ),
                      DayInfoCard(
                        image: day2Image,
                        day: day2,
                        temperature: day2Temp,
                      ),
                      DayInfoCard(
                        image: day3Image,
                        day: day3,
                        temperature: day3Temp,
                      ),
                      DayInfoCard(
                        image: day4Image,
                        day: day4,
                        temperature: day4Temp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
