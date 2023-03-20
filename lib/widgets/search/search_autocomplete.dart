import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/menu_items.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/menu_provider.dart';

class SearchAutoComplete extends StatelessWidget {
  const SearchAutoComplete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String _searchText = Provider.of<MenuProvider>(context).searchText;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: ListView.builder(
          itemCount: _searchText.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Provider.of<DataProvider>(context, listen: false)
                      .setCurrentInformationOnSearch();
                  Provider.of<MenuProvider>(context, listen: false)
                      .changeMenu(menu: MenuItems.home);
                  Provider.of<MenuProvider>(context, listen: false)
                      .setSearchText(text: '');
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300, width: 1))),
                  child: const Text(
                    'Bangalore',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
    );
  }
}
