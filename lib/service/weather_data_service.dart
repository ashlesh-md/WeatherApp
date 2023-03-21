import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/current_location_information.dart';

class WeatherDataService {
  Future<CurrentLocationInfo> getWeatherData() async {
    const String weatherDataUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=13.34&lon=74.73&appid=e031dcd3ad8b42c64dce6e16089389d6';
    final url = Uri.parse(weatherDataUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log(json.decode(response.body).toString());
      final weatherData = json.decode(response.body);
      return CurrentLocationInfo(
          climateIcon: Icons.sunny,
          dateTime: 'WED , 28 NOV 2018   11:35 AM',
          temperature: '${weatherData['main']['temp']}',
          location: '${weatherData["name"]} , ${weatherData['sys']['country']}',
          weatherInfomations: [
            WeatherInformation(
                icon: Icons.sunny, subTitle: '22° - 34°', title: 'Min - Max'),
            WeatherInformation(
                icon: Icons.cloudy_snowing,
                subTitle: '0%',
                title: 'Precepitation'),
            WeatherInformation(
                icon: Icons.water_drop_rounded,
                subTitle: '47%',
                title: 'Humidity')
          ],
          weatherStatus: 'Mostly Sunny',
          isAddedToFavourite: false,
          isCelsius: true);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
