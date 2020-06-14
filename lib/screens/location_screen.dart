import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import '../services/weather.dart';
import 'city_screen.dart';
import 'info_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  final forecastWeather;

  LocationScreen({this.locationWeather, this.forecastWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String compliment;
  int sunrise;
  int sunset;
  dynamic forecastData;
  dynamic currentWeatherData;

  bool isItDayTime;

  DateTime utc;
  String time = DateTime.now().toString();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.forecastWeather);
  }

  void updateUI(dynamic weatherData, dynamic fiveDayForecast) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        compliment =
            'Looks like we\'re having some technical difficulty.\nYou look great though!';
        cityName = '';
        sunrise = null;
        sunset = null;
        forecastData = null;
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      compliment = weather.getMessage();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      sunrise = weatherData['sys']['sunrise'];
      sunset = weatherData['sys']['sunset'];
      isItDayTime = weather.checkTimeOfDay(sunrise, sunset);
      weatherIcon = weather.getWeatherIcon(condition, isItDayTime);
      forecastData = fiveDayForecast;
      currentWeatherData = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage('images/location_background.jpg'),
//            fit: BoxFit.cover,
//            colorFilter: ColorFilter.mode(
//                Colors.white.withOpacity(0.8), BlendMode.dstATop),
//          ),
//        ),
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      var fiveDayForecast =
                          await weather.getCurrentForecastWeather();
                      updateUI(weatherData, fiveDayForecast);
                    },
                    child: Image(
                      image: AssetImage('images/locate.png'),
                      height: 30.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var citySearched = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (citySearched != null) {
                        var weatherData =
                            await weather.getCityWeather(citySearched);
                        var fiveDayForecast = await weather
                            .getSearchedForecastWeather(citySearched);
                        updateUI(weatherData, fiveDayForecast);
                      }
                    },
                    child: Image(
                      image: AssetImage('images/search.png'),
                      height: 30.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100.0, 0.0, 15.0, 0.0),
                child: Text(
                  compliment,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 10.0),
                          child: Image(
                            height: 50.0,
                            alignment: Alignment.bottomLeft,
                            image: AssetImage('images/$weatherIcon.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            cityName,
                            textAlign: TextAlign.left,
                            style: kCityNameTextStyle,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InfoScreen(
                            locationWeather: currentWeatherData,
                            forecastWeather: forecastData,
                          );
                        }));
                      },
                      child: Container(
                        height: 200.0,
                        padding: EdgeInsets.only(right: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image(
                              height: 30,
                              image: AssetImage('images/info.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
