import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'dart:math';

import 'networking.dart';

const apiKey = '4ce18c0ca03dc2b066704e885a4eabad';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        '$openWeatherMapURL/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCurrentForecastWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getSearchedForecastWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL/forecast?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  bool checkTimeOfDay(int sunrise, int sunset) {
    var currentTime = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    var dayTime;

    if (sunrise == null || sunset == null) {
      dayTime = false;
    } else {
      if (currentTime < sunrise) {
        dayTime = false;
      } else if (currentTime < sunset) {
        dayTime = true;
      } else {
        dayTime = false;
      }
    }
    return dayTime;
  }

  String getWeatherIcon(int condition, bool isItDayTime) {
    if (condition == 200 || condition == 210 || condition == 230) {
      return 'storm_light';
    } else if (condition == 201 || condition == 231) {
      return 'storm_rain';
    } else if (condition < 300) {
      return 'storm_heavy';
    } else if (condition >= 600 && condition < 700) {
      return 'snow';
    } else if (condition != 800 && condition < 804 && condition > 700) {
      return 'scattered_clouds';
    } else if (isItDayTime) {
      if (condition < 600) {
        return 'drizzle_day';
      } else if (condition == 800) {
        return 'clear_day';
      } else {
        return 'overcast_day';
      }
    } else {
      if (condition < 600) {
        return 'drizzle_night';
      } else if (condition == 800) {
        return 'clear_night';
      } else {
        return 'overcast_night';
      }
    }
  }

  String getMessage() {
    List<String> _compliments = [
      'You are more fun than anyone or anything I know, including bubble wrap',
      'You are the most perfect you there is',
      'You are enough',
      'You are one of the strongest people I know',
      'You look great today',
      'You have the best smile',
      'Your outlook on life is amazing',
      'You just light up the room',
      'You make a bigger impact than you realize',
      'You are always so helpful',
      'You have the best laugh',
      'I appreciate our friendship',
      'Your inside is even more beautiful than your outside',
      'You just glow',
      'I love the way you bring out the best in people',
      'Our family/school/community/church is better because you are part of it',
      'You bring out the best in the rest of us',
      'You inspire me',
      'Nothing can stop you',
      'You just made my day',
      'You make me float up like I’m on millions of bubbles',
      'You are an excellent friend',
      'When it comes to cooking, no one’s meals are quite as delicious',
      'I am a better person because of you',
      'You have taught me so much',
      'I like the way you are',
      'You are a great parent. You can tell just by looking at how thoughtful your kids are',
      'You have the best sense of style',
      'You make me want to be a better person',
      'You look so young!',
      'I hope you are proud of yourself, because I am!',
      'You are one of the bravest people I know',
      'That color looks perfect on you',
      'You are so trustworthy; I always believe what you say',
      'Everything seems brighter when you are around',
      'Even the things you don’t like about yourself make you interesting',
      'I know that you will always have my back, because that is the kind of person you are',
      'You have the best ideas',
      'You are a great example to others',
      'I know that if you ever make a mistake, you fix it',
      'You\’ve got great leadership skills',
      'You have amazing creative potential',
      'You are stunning',
      'You really seem to know who you are. I admire that',
      'You are the reason I am smiling today',
      'You\’re a gift to everyone you meet',
      'You have a gift for making people comfortable',
      'I enjoy spending time with you',
      'I am really glad we met',
      'I tell everyone how amazing you are',
    ];

    var quoteNumber = Random().nextInt(50);

    return _compliments[quoteNumber];
  }

  String getDayOfTheWeek(int dayOfTheWeek) {
    var dayIndex;

    if (dayOfTheWeek % 7 == 0) {
      dayIndex = 6;
    } else {
      dayIndex = (dayOfTheWeek % 7) - 1;
    }

    List<String> daysOfTheWeek = [
      'MON',
      'TUE',
      'WED',
      'THUR',
      'FRI',
      'SAT',
      'SUN',
    ];
    return daysOfTheWeek[dayIndex];
  }

  int getWeatherIndex(int hour) {
    return hour < 3
        ? 4
        : hour < 6
            ? 3
            : hour < 9
                ? 2
                : hour < 12
                    ? 1
                    : hour < 15 ? 0 : hour < 18 ? 7 : hour < 21 ? 6 : 5;
  }

//  String getDayWeatherIcon(List forecastData) {
//    forecastData
//  }
}
