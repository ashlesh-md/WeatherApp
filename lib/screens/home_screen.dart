import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/storage/favourites_storage.dart';
import 'package:weather_app/storage/recent_search_storage.dart';

import '../providers/data_provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/scaffold_widgets/custom_background.dart';
import '../widgets/scaffold_widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirst = true;

  final recentSearchStorage = RecentSearchStorage();

  final favouritesStorage = FavouritesStorage();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      try {
        Provider.of<DataProvider>(context, listen: false).getCurrentLocation();
        recentSearchStorage
            .readRecentSearchData()
            .then((value) {
              if (value.isNotEmpty) {
                value.split(' ').toSet().toList().forEach((element) {
                  // log(element);
                  Provider.of<DataProvider>(context, listen: false)
                      .setCurrentInformationOnSearch(cityName: element);
                });
              }
            })
            .then((value) => favouritesStorage.readFavouritesData().then((fav) {
                  if (fav.isNotEmpty) {
                    fav.split(' ').toSet().toList().forEach((element) {
                      log('Favourite : $element');
                      Provider.of<DataProvider>(context, listen: false)
                          .setFavouritesFromTheStorage(cityName: element);
                    });
                  }
                }))
            .then(
              (value) {
                Future.delayed(
                  Duration.zero,
                  () {
                    setState(() {
                      isLoading = false;
                    });
                  },
                );
              },
            );
      } catch (e) {
        Provider.of<DataProvider>(context, listen: false).getCurrentLocation();
      }
      isFirst = false;
    }

    final menuProvider = Provider.of<MenuProvider>(context);

    return SafeArea(
      child: CustomBackground(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: menuProvider.selectedAppbar,
                drawer: const CustomDrawer(),
                body: menuProvider.selectedWidget,
              ),
      ),
    );
  }
}
