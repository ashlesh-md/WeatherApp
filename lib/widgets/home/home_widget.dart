import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';

import './current_location_information.dart';
import './weather_information.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherInformation = Provider.of<DataProvider>(context)
        .currentLoactionInformation
        .weatherInfomations;
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: CurrentLocationInformation(),
                ),
                Expanded(
                  flex: 3,
                  child: WeatherInformation(),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border(
                  top: BorderSide(
                      color: Colors.white.withOpacity(0.5), width: 1))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int index = 0; index < weatherInformation.length; index++)
                  Container(
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      children: [
                        Icon(
                          weatherInformation[index].icon,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weatherInformation[index].title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              weatherInformation[index].subTitle,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
