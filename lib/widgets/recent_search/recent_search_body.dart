import 'package:flutter/material.dart';

import '../common_widgets/favourite_recent_search_header.dart';
import '../common_widgets/weather_info_tile.dart';

class RecentSearchBody extends StatelessWidget {
  const RecentSearchBody({super.key});
  final String countString = 'You recently searched for';
  final String dialogString =
      'Are you sure want to remove all the Recent Search?';
  final String removeString = 'Clear All';

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
