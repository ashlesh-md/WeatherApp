import 'package:flutter/material.dart';

int _counter = 11111111;

class CurrentLocationInfo {
  String currentLocationId = '';
  String location;
  bool isAddedToFavourite;
  IconData climateIcon;
  String temperature;
  bool isCelsius;
  String weatherStatus;
  String date;
  DateTime time;
  List<WeatherInformation> weatherInfomations;
  CurrentLocationInfo(
      {required this.location,
      this.isAddedToFavourite = false,
      required this.climateIcon,
      required this.temperature,
      this.isCelsius = true,
      required this.weatherStatus,
      required this.date,
      required this.time,
      required this.weatherInfomations});
}

class WeatherInformation {
  final String title;
  final String subTitle;
  final IconData icon;
  WeatherInformation(
      {required this.title, required this.subTitle, required this.icon});
}

class WeatherInfoTile {
  final String id = '${_counter++}';
  String location;
  bool isAddedToFavourite;
  IconData climateIcon;
  String weatherStatus;
  String temperature;

  WeatherInfoTile({
    required this.location,
    this.isAddedToFavourite = false,
    required this.climateIcon,
    required this.weatherStatus,
    required this.temperature,
  });
}
