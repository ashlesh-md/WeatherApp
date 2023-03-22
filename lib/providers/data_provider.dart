import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/service/weather_data_service.dart';

import '../models/current_location_information.dart';

class DataProvider extends ChangeNotifier {
  CurrentLocationInfo _currentLoactionInformation = CurrentLocationInfo(
      climateIcon: Icons.sunny,
      dateTime: 'WED , 28 NOV 2018   11:35 AM',
      temperature: '31',
      location: 'Udupi , Karnataka',
      weatherInfomations: [
        WeatherInformation(
            icon: Icons.sunny, subTitle: '22° - 34°', title: 'Min - Max'),
        WeatherInformation(
            icon: Icons.cloudy_snowing, subTitle: '0%', title: 'Precepitation'),
        WeatherInformation(
            icon: Icons.water_drop_rounded, subTitle: '47%', title: 'Humidity')
      ],
      weatherStatus: 'Mostly Sunny',
      isAddedToFavourite: false,
      isCelsius: true);
  final List<WeatherInfoTile> _favourites = [];
  final List<WeatherInfoTile> _recentSearches = [];

  CurrentLocationInfo get currentLoactionInformation =>
      _currentLoactionInformation;
  List<WeatherInfoTile> get favourites => [..._favourites];
  List<WeatherInfoTile> get recentSearch => [..._recentSearches];
  String _temporaryTemprature = '';

  void clearRecentSearches() {
    _recentSearches.clear();
    Fluttertoast.showToast(
        msg: 'All the recent searches are cleared',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  // void clearRecentSearches() {
  //   var temp = [..._favourites.sublist(0, _favourites.length - 1)];
  //   for (var element in _favourites) {
  //     if (_recentSearches.contains(element)) {
  //       temp.remove(element);
  //     }
  //   }
  //   _favourites.clear();
  //   _favourites.addAll(temp);
  //   _recentSearches.clear();
  //   Fluttertoast.showToast(
  //       msg: 'All the recent searches are cleared',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black.withOpacity(0.8),
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //   notifyListeners();
  // }
  void clearFavourites() {
    for (var element in _favourites) {
      if (element.id == _currentLoactionInformation.currentLocationId) {
        _currentLoactionInformation.isAddedToFavourite = false;
      }
      if (_recentSearches.contains(element)) {
        _recentSearches[_recentSearches.indexOf(element)].isAddedToFavourite =
            false;
      }
    }
    _favourites.clear();

    Fluttertoast.showToast(
        msg: 'All the favourites are cleared',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  void changeFavouriteStatusOfCurrentLoaction() {
    _currentLoactionInformation.isAddedToFavourite =
        !_currentLoactionInformation.isAddedToFavourite;
    WeatherInfoTile weatherData;
    if (_currentLoactionInformation.isAddedToFavourite) {
      if (_recentSearches.isNotEmpty) {
        _recentSearches.last.isAddedToFavourite = true;
        weatherData = _recentSearches.last;
      } else {
        weatherData = WeatherInfoTile(
            climateIcon: _currentLoactionInformation.climateIcon,
            location: _currentLoactionInformation.location,
            temperature: _currentLoactionInformation.temperature,
            weatherStatus: _currentLoactionInformation.weatherStatus,
            isAddedToFavourite: _currentLoactionInformation.isAddedToFavourite);
      }

      if (!_favourites.contains(weatherData)) _favourites.add(weatherData);
      _currentLoactionInformation.currentLocationId = _favourites.last.id;
      if (_recentSearches.contains(weatherData)) {
        _recentSearches[_recentSearches.indexOf(weatherData)]
            .isAddedToFavourite = true;
      }
    } else {
      _favourites.removeWhere((element) =>
          element.id == _currentLoactionInformation.currentLocationId);
    }
    Fluttertoast.showToast(
        msg: _currentLoactionInformation.isAddedToFavourite
            ? "Added to the favourites"
            : "Removed from the favourites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  void changeDegreeCelsiusInCurrentLoaction({required bool status}) {
    if (_currentLoactionInformation.isCelsius) {
      _temporaryTemprature = _currentLoactionInformation.temperature;
    }
    _currentLoactionInformation.isCelsius = status;
    if (_currentLoactionInformation.isCelsius) {
      _currentLoactionInformation.temperature = _temporaryTemprature;
    } else if (!currentLoactionInformation.isCelsius) {
      var temp = double.parse(_currentLoactionInformation.temperature);
      _currentLoactionInformation.temperature =
          (temp * (9 / 5) + 32).toString();
    }
    notifyListeners();
  }

  void removeFromFavouriteById({required String id}) {
    _favourites.removeWhere((element) => element.id == id);
    try {
      _recentSearches
          .firstWhere((element) => element.id == id)
          .isAddedToFavourite = false;
    } catch (e) {
      log(e.toString());
    }
    if (_currentLoactionInformation.currentLocationId == id) {
      _currentLoactionInformation.isAddedToFavourite = false;
    }
    notifyListeners();
  }

  WeatherInfoTile getRecentSearchDataById({required String id}) =>
      _recentSearches.firstWhere((element) => element.id == id);

  void addAndRemoveRecentSearchFromFavouriteList({required String id}) {
    WeatherInfoTile searchElement = getRecentSearchDataById(id: id);
    if (searchElement.isAddedToFavourite) {
      _favourites.remove(searchElement);
      searchElement.isAddedToFavourite = false;
    } else {
      searchElement.isAddedToFavourite = true;
      _favourites.add(searchElement);
    }
    Fluttertoast.showToast(
        msg: searchElement.isAddedToFavourite
            ? "Added to the favourites"
            : "Removed from the favourites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  Future<void> setCurrentInformationOnSearch({required String cityName}) async {
    await WeatherDataService().getWeatherData(cityName: cityName).then((value) {
      if (_currentLoactionInformation.location != value.location) {
        _currentLoactionInformation = value;
        _recentSearches.add(
          WeatherInfoTile(
              climateIcon: _currentLoactionInformation.climateIcon,
              location: _currentLoactionInformation.location,
              temperature: _currentLoactionInformation.temperature,
              weatherStatus: _currentLoactionInformation.weatherStatus,
              isAddedToFavourite: false),
        );
      }
    });
    notifyListeners();
  }
}
