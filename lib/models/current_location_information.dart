import 'package:flutter/material.dart';

int _counter = 11111111;

class CurrentLocationInfo {
  String currentLocationId = '';
  String dateTime;
  String location;
  bool isAddedToFavourite;
  IconData climateIcon;
  String temperature;
  bool isCelsius;
  String weatherStatus;
  List<WeatherInformation> weatherInfomations;
  CurrentLocationInfo(
      {required this.dateTime,
      required this.location,
      this.isAddedToFavourite = false,
      required this.climateIcon,
      required this.temperature,
      this.isCelsius = true,
      required this.weatherStatus,
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
  String id = '${_counter++}';
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
