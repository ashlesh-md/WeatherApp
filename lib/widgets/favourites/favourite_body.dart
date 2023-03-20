import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/current_location_information.dart';
import '../../providers/data_provider.dart';
import '../common_widgets/empty_search_favourite.dart';
import '../common_widgets/favourite_recent_search_header.dart';
import '../common_widgets/weather_info_tile.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});
  final String dialogString = 'Are you sure want to remove all the favourites?';
  final String removeString = 'Remove All';

  @override
  Widget build(BuildContext context) {
    List<WeatherInfoTile> favourites =
        Provider.of<DataProvider>(context).favourites;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FavouriteRecentSearchHeader(
              isFavouriteScreen: true,
              countString: '${favourites.length} City added as favourite',
              dialogString: dialogString,
              removeString: removeString),
          const SizedBox(
            height: 30,
          ),
          if (favourites.isEmpty) const Expanded(child: SizedBox()),
          if (favourites.isEmpty)
            const Center(
                child: EmptySearchFavourite(text: 'No Favourites Added')),
          if (favourites.isEmpty) const Expanded(child: SizedBox()),
          Expanded(
            child: ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) => Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 1.5),
                  child: WeatherInformationTile(
                    id: favourites[index].id,
                    climateIcon: favourites[index].climateIcon,
                    location: favourites[index].location,
                    temperature: favourites[index].temperature,
                    weatherStatus: favourites[index].weatherStatus,
                    isAddedToFavourite: favourites[index].isAddedToFavourite,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
