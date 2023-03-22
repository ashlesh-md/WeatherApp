import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../providers/menu_provider.dart';
import '../storage/data_storage.dart';
import '../widgets/scaffold_widgets/custom_background.dart';
import '../widgets/scaffold_widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.storage});
  final CounterStorage storage;

  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      storage.readCounter().then((value) {
        print(value);
        if (value.isNotEmpty) {
          value.split(' ').toSet().toList().forEach((element) {
            log(element);
            Provider.of<DataProvider>(context, listen: false)
                .setCurrentInformationOnSearch(cityName: element)
                .then((value) => log(element));
          });
        }
      });
      isFirst = false;
    }

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
