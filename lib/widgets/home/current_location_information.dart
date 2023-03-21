import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';

import '../../models/current_location_information.dart';

class CurrentLocationInformation extends StatelessWidget {
  const CurrentLocationInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CurrentLocationInfo currentLocationData =
        Provider.of<DataProvider>(context).currentLoactionInformation;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: double.maxFinite,
      children: [
        Text(
          currentLocationData.dateTime,
          textAlign: TextAlign.center,
          style: TextStyle(
              letterSpacing: 2,
              color: Colors.grey.shade100,
              fontSize: 17,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 15),
        Text(
          currentLocationData.location,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            Provider.of<DataProvider>(context, listen: false)
                .changeFavouriteStatusOfCurrentLoaction();
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              // alignment: WrapAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentLocationData.isAddedToFavourite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: currentLocationData.isAddedToFavourite
                      ? const Color.fromRGBO(250, 208, 90, 1)
                      : Colors.white,
                  size: 32,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Add to favourite',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
