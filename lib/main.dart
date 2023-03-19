import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/menu_provider.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            child: Container(
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
            ),
          )),
    );
  }
}
