import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';

class FavouriteRecentSearchHeader extends StatelessWidget {
  const FavouriteRecentSearchHeader(
      {super.key,
      required this.countString,
      required this.dialogString,
      required this.removeString,
      required this.isFavouriteScreen});

  final String countString;
  final String dialogString;
  final String removeString;
  final bool isFavouriteScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          countString,
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontStyle: FontStyle.normal),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    dialogString,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(103, 58, 184, 1)),
                        )),
                    TextButton(
                      onPressed: () {
                        if (isFavouriteScreen) {
                          Provider.of<DataProvider>(context, listen: false)
                              .clearFavourites();
                          log(Provider.of<DataProvider>(context, listen: false)
                              .favourites
                              .toString());
                          log('isFavouriteScreen cleared');
                        } else {
                          Provider.of<DataProvider>(context, listen: false)
                              .clearRecentSearches();
                          log(Provider.of<DataProvider>(context, listen: false)
                              .recentSearch
                              .toString());
                          log('clearRecentSearchess cleared');
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(103, 58, 184, 1)),
                      ),
                    )
                  ],
                );
              },
            );
          },
          child: Text(
            removeString,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontStyle: FontStyle.normal),
          ),
        )
      ],
    );
  }
}
