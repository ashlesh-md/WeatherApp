import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/scaffold_widgets/custom_background.dart';
import '../widgets/scaffold_widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final currentLocationData =
        Provider.of<DataProvider>(context).currentLoactionInformation;

    return SafeArea(
      child: CustomBackground(
        child: currentLocationData == null
            ? Scaffold(body: Container(color: Colors.transparent))
            : Scaffold(
                appBar: menuProvider.selectedAppbar,
                drawer: const CustomDrawer(),
                body: menuProvider.selectedWidget,
              ),
      ),
    );
  }
}
