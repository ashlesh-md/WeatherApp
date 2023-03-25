import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/current_location_information.dart';

class WeatherDataService {
  Future<CurrentLocationInfo?> getWeatherData(
      {required String cityName}) async {
    const String apiKey = 'e031dcd3ad8b42c64dce6e16089389d6';
    // 'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$e031dcd3ad8b42c64dce6e16089389d6',
    final String weatherDataUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    log('GetWeatherData : $weatherDataUrl');
    final url = Uri.parse(weatherDataUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(json.decode(response.body).toString());
      final weatherData = json.decode(response.body);
      CurrentLocationInfo? currentLocationInfo;
      await assignWeatherData(
              lat: double.parse(weatherData['coord']['lon'].toString()),
              long: double.parse(weatherData['coord']['lon'].toString()))
          .then((value) {
        List<String> time =
            value['time_12'].toString().split(' ').first.toString().split(':');
        log('time : $time');
        String isAm = value['time_12'].toString().split(' ').last;
        currentLocationInfo = CurrentLocationInfo(
            isAm: isAm,
            climateIcon: Icons.sunny,
            date: value['date_time_wti'].toString().substring(0, 17),
            time: DateTime(
              value['year'],
              value['month'],
              int.parse(value['date'].toString().split('-').last),
              int.parse(time[0].toString()),
              int.parse(time[1].toString()),
              int.parse(time[2].toString()),
            ),
            temperature: '${weatherData['main']['temp']}',
            location:
                '${weatherData["name"]} , ${weatherData['sys']['country']}',
            lat: double.parse(weatherData['coord']['lat'].toString()),
            long: double.parse(weatherData['coord']['lon'].toString()),
            weatherInfomations: [
              WeatherInformation(
                  icon: Icons.sunny,
                  subTitle:
                      '${weatherData['main']['temp_max']}° - ${weatherData['main']['temp_min']}°',
                  title: 'Min - Max'),
              WeatherInformation(
                  icon: Icons.cloudy_snowing,
                  subTitle: '${weatherData['main']['sea_level']}',
                  title: 'See level'),
              WeatherInformation(
                  icon: Icons.water_drop_rounded,
                  subTitle: '${weatherData['main']['humidity']}%',
                  title: 'Humidity'),
              WeatherInformation(
                  icon: Icons.visibility,
                  subTitle: '${weatherData['visibility']}',
                  title: 'Visibility')
            ],
            weatherStatus: weatherData['weather'][0]['description'],
            isAddedToFavourite: false,
            isCelsius: true);
      });
      return currentLocationInfo;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CurrentLocationInfo?> getWeatherDataByLatLong(
      {required double lat, required double long}) async {
    const String apiKey = 'e031dcd3ad8b42c64dce6e16089389d6';

    final String weatherDataUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey';
    final url = Uri.parse(weatherDataUrl);
    log('weatherDataUrl  $weatherDataUrl');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log('${json.decode(response.body)}');
      final weatherData = json.decode(response.body);
      CurrentLocationInfo? currentLocationInfo;
      await getWeatherData(cityName: weatherData['name']).then(
        (value) {
          currentLocationInfo = value;
        },
      );

      return currentLocationInfo;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> assignWeatherData(
      {required double lat, required double long}) async {
    const apiKey = '2fdba03c75ec4d5782397929635e931c';
    final String timeDataApi =
        'https://api.ipgeolocation.io/timezone?apiKey=$apiKey&lat=$lat&long=$long';
    log(timeDataApi);
    final url = Uri.parse(timeDataApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(json.decode(response.body).toString());
      final timeData = json.decode(response.body);
      return timeData as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
