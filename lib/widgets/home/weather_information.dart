import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';
import '../../providers/data_provider.dart';

class WeatherInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        const Icon(Icons.sunny, color: Colors.white, size: 125),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              double.parse(Provider.of<DataProvider>(context)
                      .currentLoactionInformation
                      .temperature)
                  .toStringAsFixed(0),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.only(bottom: 17),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!dataProvider.currentLoactionInformation.isCelsius) {
                        dataProvider.changeDegreeCelsiusInCurrentLoaction(
                            status: true);
                      }
                    },
                    child: Container(
                      width: 35,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      decoration:
                          dataProvider.currentLoactionInformation.isCelsius
                              ? selectedDecoration(isLeft: true)
                              : unSelectedDecoration(isLeft: true),
                      child: Text(
                        '°C ',
                        style: dataProvider.currentLoactionInformation.isCelsius
                            ? const TextStyle(color: Colors.red, fontSize: 22)
                            : const TextStyle(
                                color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (dataProvider.currentLoactionInformation.isCelsius) {
                        dataProvider.changeDegreeCelsiusInCurrentLoaction(
                            status: false);
                      }
                    },
                    child: Container(
                      width: 35,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      decoration:
                          dataProvider.currentLoactionInformation.isCelsius
                              ? unSelectedDecoration(isLeft: false)
                              : selectedDecoration(isLeft: false),
                      child: Text(
                        '°F ',
                        style: !dataProvider
                                .currentLoactionInformation.isCelsius
                            ? const TextStyle(color: Colors.red, fontSize: 22)
                            : const TextStyle(
                                color: Colors.white, fontSize: 22),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 30),
        const Text(
          'Mostly Sunny',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }
}
