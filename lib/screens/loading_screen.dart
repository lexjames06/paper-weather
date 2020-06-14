import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getCurrentForecastWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
        forecastWeather: forecastData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
