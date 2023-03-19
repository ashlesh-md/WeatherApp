import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/menu_items.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/menu_provider.dart';

class WeatherInformationTile extends StatelessWidget {
  const WeatherInformationTile({
    super.key,
    required this.id,
    required this.location,
    this.isAddedToFavourite = false,
    required this.climateIcon,
    required this.weatherStatus,
    required this.temperature,
  });
  final String id;
  final String location;
  final bool isAddedToFavourite;
  final IconData climateIcon;
  final String weatherStatus;
  final String temperature;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.125),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                    color: Color.fromRGBO(254, 229, 56, 1),
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    climateIcon,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$temperature °c',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.normal),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    weatherStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              if (Provider.of<MenuProvider>(context, listen: false)
                      .selectedMenu ==
                  MenuItems.favourite) {
                Provider.of<DataProvider>(context, listen: false)
                    .removeFromFavouriteById(id: id);
              }
              if (Provider.of<MenuProvider>(context, listen: false)
                      .selectedMenu ==
                  MenuItems.recentSearch) {
                Provider.of<DataProvider>(context, listen: false)
                    .addAndRemoveRecentSearchFromFavouriteList(id: id);
              }
            },
            child: Icon(
              isAddedToFavourite ? Icons.favorite : Icons.favorite_outline,
              size: 28,
              color: const Color.fromRGBO(250, 208, 90, 1),
            ),
          )
        ],
      ),
    );
  }
}
