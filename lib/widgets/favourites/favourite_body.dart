import 'package:flutter/material.dart';

import '../common_widgets/favourite_recent_search_header.dart';
import '../common_widgets/weather_info_tile.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});
  final String countString = '6 City added as favourite';
  final String dialogString = 'Are you sure want to remove all the favourites?';
  final String removeString = 'Remove All';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FavouriteRecentSearchHeader(
              countString: countString,
              dialogString: dialogString,
              removeString: removeString),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 1.5),
                  child: const WeatherInformationTile()),
            ),
          )
        ],
      ),
    );
  }
}
