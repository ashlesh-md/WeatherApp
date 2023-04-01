import 'dart:developer';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/menu_provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/storage/favourites_storage.dart';
import 'package:weather_app/storage/recent_search_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final recentSearchStorage = RecentSearchStorage();
  final favouritesStorage = FavouritesStorage();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider())
      ],
      child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent, elevation: 0)),
          home: SafeArea(
            child: Builder(builder: (context) {
              favouritesStorage.readFavouritesData().then((fav) {
                print('Favourites : $fav');
                if (fav.isNotEmpty) {
                  'Mangalore\nMysore\n\\ooty'
                      .split('\n')
                      .toSet()
                      .toList()
                      .forEach((element) {
                    log('Favourite : $element');
                    log('Favourites : ${fav.split('\n').toSet().toList()}');
                    Provider.of<DataProvider>(context, listen: false)
                        .setFavouritesFromTheStorage(cityName: element);
                  });
                }
              });
              recentSearchStorage.readRecentSearchData().then((recent) {
                if (recent.isNotEmpty) {
                  recent.split('\n').toSet().toList().forEach((element) {
                    log(recent.split('\n').toSet().toList().toString());
                    Provider.of<DataProvider>(context, listen: false)
                        .setCurrentInformationOnSearch(cityName: element);
                  });
                }
              });

              if (Provider.of<DataProvider>(context, listen: false)
                      .currentLoactionInformation ==
                  null) {
                if (Platform.isAndroid || Platform.isIOS) {
                  log('Get Currentlocation');
                  Provider.of<DataProvider>(context, listen: false)
                      .getCurrentLocation();
                } else {
                  log('Get setDefaultLocation');
                  Provider.of<DataProvider>(context, listen: false)
                      .setDefaultLocation();
                }
              }
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/splash/background_android.png',
                        ),
                        fit: BoxFit.fill)),
                child: AnimatedSplashScreen(
                  duration: 3000,
                  splash: Image.asset('assets/images/splash/logo_splash.png'),
                  nextScreen: const HomeScreen(),
                  splashTransition: SplashTransition.fadeTransition,
                  backgroundColor: Colors.transparent,
                ),
              );
            }),
          )),
    );
  }
}
