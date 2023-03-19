import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/empty_search_favourite.dart';
import '/providers/data_provider.dart';
import '../../models/current_location_information.dart';
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
    List<WeatherInfoTile> recentSearchData =
        Provider.of<DataProvider>(context).recentSearch;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FavouriteRecentSearchHeader(
              isFavouriteScreen: false,
              countString: countString,
              dialogString: dialogString,
              removeString: removeString),
          const SizedBox(
            height: 30,
          ),
          if (recentSearchData.isEmpty) const Expanded(child: SizedBox()),
          if (recentSearchData.isEmpty)
            const EmptySearchFavourite(text: 'No Recent Search'),
          if (recentSearchData.isEmpty) const Expanded(child: SizedBox()),
          Expanded(
            child: ListView.builder(
              itemCount: recentSearchData.length,
              itemBuilder: (context, index) => Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 1.5),
                  child: WeatherInformationTile(
                    id: recentSearchData[index].id,
                    climateIcon: recentSearchData[index].climateIcon,
                    location: recentSearchData[index].location,
                    temperature: recentSearchData[index].temperature,
                    weatherStatus: recentSearchData[index].weatherStatus,
                    isAddedToFavourite:
                        recentSearchData[index].isAddedToFavourite,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
