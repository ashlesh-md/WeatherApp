import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/service/weather_data_service.dart';

import '../providers/menu_provider.dart';
import '../widgets/scaffold_widgets/custom_background.dart';
import '../widgets/scaffold_widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherDataService().getWeatherData();
    final menuProvider = Provider.of<MenuProvider>(context);

    return SafeArea(
      child: CustomBackground(
        child: Scaffold(
          appBar: menuProvider.selectedAppbar,
          drawer: const CustomDrawer(),
          body: menuProvider.selectedWidget,
        ),
      ),
    );
  }
}
