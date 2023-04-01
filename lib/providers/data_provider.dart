import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/service/weather_data_service.dart';
import 'package:weather_app/storage/favourites_storage.dart';

import '../models/current_location_information.dart';
import '../storage/recent_search_storage.dart';

class DataProvider extends ChangeNotifier {
  CurrentLocationInfo? _currentLoactionInformation;

  Future<void> getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      log('No Permission');
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      log(position.toString());
      log('${position.latitude} ${position.longitude}');
      await WeatherDataService()
          .getWeatherDataByLatLong(
              lat: position.latitude, long: position.longitude)
          .then((value) {
        log('CurrentLocationData getWeatherDataByLatLong : $value');
        _currentLoactionInformation = value!;
      });
    }).onError((error, stackTrace) async {
      print(error);
      await WeatherDataService()
          .getWeatherData(cityName: 'Mangalore')
          .then((value) {
        log('CurrentLocationData getWeatherData : $value');
        _currentLoactionInformation = value!;
      });
    });
    notifyListeners();
  }

  Future<void> setDefaultLocation() async {
    await WeatherDataService()
        .getWeatherData(cityName: 'Mangalore')
        .then((value) {
      log('CurrentLocationData getWeatherData : $value');
      _currentLoactionInformation = value!;
    });
  }

  void setCurrentLocationTime({required DateTime time}) {
    _currentLoactionInformation!.time = time;
    notifyListeners();
  }

  final List<WeatherInfoTile> _favourites = [];

  final List<WeatherInfoTile> _recentSearches = [];

  CurrentLocationInfo? get currentLoactionInformation =>
      _currentLoactionInformation;
  List<WeatherInfoTile> get favourites {
    var temp = [];
    List<WeatherInfoTile> tempFavourites = [];
    for (var search in _favourites) {
      if (!temp.contains(search.location)) {
        temp.add(search.location);
        tempFavourites.add(search);
      }
    }
    _favourites.clear();
    _favourites.addAll(tempFavourites);
    return [..._favourites.toSet().toList()];
  }

  List<WeatherInfoTile> get recentSearch {
    var temp = [];
    List<WeatherInfoTile> tempSearches = [];
    for (var search in _recentSearches) {
      if (!temp.contains(search.location)) {
        temp.add(search.location);
        tempSearches.add(search);
      }
    }
    _recentSearches.clear();
    _recentSearches.addAll(tempSearches);
    return [..._recentSearches.toSet().toList()];
  }

  String _temporaryTemprature = '';

  void clearRecentSearches() {
    RecentSearchStorage().deleteRecentSearchData();
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

  void clearFavourites() {
    FavouritesStorage().deleteFavouritesData();

    for (var element in _favourites) {
      if (element.id == _currentLoactionInformation!.currentLocationId) {
        _currentLoactionInformation!.isAddedToFavourite = false;
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
    _favourites.removeWhere(
        (element) => element.location == currentLoactionInformation!.location);
    _currentLoactionInformation!.isAddedToFavourite =
        !_currentLoactionInformation!.isAddedToFavourite;

    WeatherInfoTile weatherData;
    if (_currentLoactionInformation!.isAddedToFavourite) {
      if (_recentSearches.isNotEmpty) {
        _recentSearches.last.isAddedToFavourite = true;
        weatherData = _recentSearches.last;
      } else {
        weatherData = WeatherInfoTile(
            climateIcon: _currentLoactionInformation!.climateIcon,
            location: _currentLoactionInformation!.location,
            temperature: _currentLoactionInformation!.temperature,
            weatherStatus: _currentLoactionInformation!.weatherStatus,
            isAddedToFavourite:
                _currentLoactionInformation!.isAddedToFavourite);
        _favourites.add(weatherData);
      }

      if (!_favourites.contains(weatherData)) _favourites.add(weatherData);
      if (_recentSearches.contains(weatherData)) {
        _recentSearches[_recentSearches.indexOf(weatherData)]
            .isAddedToFavourite = true;
      }
      _currentLoactionInformation!.currentLocationId = _favourites.last.id;
      if (_recentSearches.contains(weatherData)) {
        _recentSearches[_recentSearches.indexOf(weatherData)]
            .isAddedToFavourite = true;
      }
    } else {
      for (var element in _recentSearches) {
        if (element.location == currentLoactionInformation!.location) {
          element.isAddedToFavourite = false;
        }
      }
    }
    for (var element in _recentSearches) {
      log('$element' 'Addded');
      if (element.location == _currentLoactionInformation!.location) {
        element.isAddedToFavourite = true;
      }
    }
    Fluttertoast.showToast(
        msg: _currentLoactionInformation!.isAddedToFavourite
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
    if (_currentLoactionInformation!.isCelsius) {
      _temporaryTemprature = _currentLoactionInformation!.temperature;
    }
    _currentLoactionInformation!.isCelsius = status;
    if (_currentLoactionInformation!.isCelsius) {
      _currentLoactionInformation!.temperature = _temporaryTemprature;
    } else if (!currentLoactionInformation!.isCelsius) {
      var temp = double.parse(_currentLoactionInformation!.temperature);
      _currentLoactionInformation!.temperature =
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
    if (_currentLoactionInformation!.currentLocationId == id) {
      _currentLoactionInformation!.isAddedToFavourite = false;
    }
    notifyListeners();
  }

  WeatherInfoTile getRecentSearchDataById({required String id}) =>
      _recentSearches.firstWhere((element) => element.id == id);

  void addAndRemoveRecentSearchFromFavouriteList({required String id}) {
    WeatherInfoTile searchElement = getRecentSearchDataById(id: id);
    _favourites
        .removeWhere((element) => element.location == searchElement.location);
    if (searchElement.isAddedToFavourite) {
      _favourites.remove(searchElement);
      searchElement.isAddedToFavourite = false;
      if (searchElement.location == currentLoactionInformation!.location) {
        currentLoactionInformation!.isAddedToFavourite = false;
      }
    } else {
      searchElement.isAddedToFavourite = true;
      if (searchElement.location == currentLoactionInformation!.location) {
        currentLoactionInformation!.isAddedToFavourite = true;
      }
      _favourites.add(searchElement);
      FavouritesStorage().readFavouritesData().then((fav) {
        print(fav);
        if (fav.isNotEmpty) {
          fav.split('\n').toSet().toList().forEach((element) {
            log('Favourite : $element');
            log('Favourites : ${fav.split('\n').toSet().toList()}');
            setFavouritesFromTheStorage(cityName: element);
          });
        }
      });
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
    await WeatherDataService()
        .getWeatherData(cityName: cityName)
        .then((value) async {
      await RecentSearchStorage().readRecentSearchData().then((value) async =>
          await RecentSearchStorage()
              .writeRecentSearchData('$value\n$cityName'));
      _currentLoactionInformation = value!;
      _recentSearches.add(
        WeatherInfoTile(
            climateIcon: value.climateIcon,
            location: value.location,
            temperature: value.temperature,
            weatherStatus: value.weatherStatus,
            isAddedToFavourite: value.isAddedToFavourite),
      );
    });
    notifyListeners();
  }

  Future<void> setFavouritesFromTheStorage({required String cityName}) async {
    await WeatherDataService()
        .getWeatherData(cityName: cityName)
        .then((value) async {
      await FavouritesStorage().readFavouritesData().then((value) async {
        await FavouritesStorage().writeFavouritesData('$value\n$cityName');
      });
      // var temp = [..._favourites];
      // for (var seach in _favourites) {
      //   if (seach.location == value!.location) {
      //     temp.remove(seach);
      //   }
      // }
      // _favourites.clear();
      // _favourites.addAll(temp);
      _favourites.add(
        WeatherInfoTile(
            climateIcon: value!.climateIcon,
            location: value.location,
            temperature: value.temperature,
            weatherStatus: value.weatherStatus,
            isAddedToFavourite: true),
      );
    });
    notifyListeners();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
}
