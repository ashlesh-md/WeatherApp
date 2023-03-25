import 'dart:developer';

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
              Provider.of<DataProvider>(context, listen: false)
                  .getCurrentLocation();
              recentSearchStorage.readRecentSearchData().then((recent) {
                if (recent.isNotEmpty) {
                  recent.split(' ').toSet().toList().forEach((element) {
                    log(recent.split(' ').toSet().toList().toString());
                    Provider.of<DataProvider>(context, listen: false)
                        .setCurrentInformationOnSearch(cityName: element);
                  });
                }
              }).then(
                  (value) => favouritesStorage.readFavouritesData().then((fav) {
                        if (fav.isNotEmpty) {
                          fav.split(' ').toSet().toList().forEach((element) {
                            log('Favourite : $element');
                            log(fav.split(' ').toSet().toList().toString());

                            Provider.of<DataProvider>(context, listen: false)
                                .setFavouritesFromTheStorage(cityName: element);
                          });
                        }
                      }));
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
