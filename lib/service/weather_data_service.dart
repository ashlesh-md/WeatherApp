import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/current_location_information.dart';

class WeatherDataService {
  Future<CurrentLocationInfo> getWeatherData({required String cityName}) async {
    const String apiKey = 'e031dcd3ad8b42c64dce6e16089389d6';
    // 'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$e031dcd3ad8b42c64dce6e16089389d6',
    final String weatherDataUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    final url = Uri.parse(weatherDataUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log(json.decode(response.body).toString());
      final weatherData = json.decode(response.body);
      return CurrentLocationInfo(
          climateIcon: Icons.sunny,
          date: 'WED , 28 NOV 2018',
          time: DateTime.now(),
          temperature: '${weatherData['main']['temp']}',
          location: '${weatherData["name"]} , ${weatherData['sys']['country']}',
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
    } else {
      throw Exception('Failed to load data');
    }
  }
}
