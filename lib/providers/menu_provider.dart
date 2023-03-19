import 'package:flutter/material.dart';
import 'package:weather_app/constants/menu_items.dart';
import 'package:weather_app/widgets/common_widgets/favourite_recent_search_appbar.dart';
import 'package:weather_app/widgets/home/home_widget.dart';
import 'package:weather_app/widgets/recent_search/recent_search_body.dart';
import 'package:weather_app/widgets/scaffold_widgets/custom_appbar.dart';
import 'package:weather_app/widgets/search/search_appbar.dart';

import '../widgets/favourites/favourite_body.dart';

class MenuProvider extends ChangeNotifier {
  MenuItems _selectedMenu = MenuItems.home;
  bool _search = false;
  final List<Widget> _menuHandlerWidgets = [
    const HomeWidget(),
    const FavouriteBody(),
    const RecentSearchBody(),
  ];
  Widget _selectedWidget = const HomeWidget();
  get selectedWidget => _selectedWidget;
  get selectedMenu => _selectedMenu;

  Widget _selectedAppbar = CustomAppbar();
  get selectedAppbar => _selectedAppbar;
  void changeSearchStatus() {
    _search = !_search;
    if (_search) {
      _selectedAppbar = SearchAppbar();
      _selectedWidget = Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      );
    } else {
      _selectedAppbar = CustomAppbar();
      changeMenu(menu: _selectedMenu);
    }
    notifyListeners();
  }

  changeMenu({required MenuItems menu}) {
    _selectedMenu = menu;
    _search = false;
    _selectedAppbar = CustomAppbar();
    switch (menu) {
      case MenuItems.home:
        _selectedWidget = _menuHandlerWidgets[0];
        break;
      case MenuItems.favourite:
        _selectedWidget = _menuHandlerWidgets[1];
        _selectedAppbar = const FavouriteRecentSearchAppbar(
          text: 'Favourite',
        );
        break;
      case MenuItems.recentSearch:
        _selectedWidget = _menuHandlerWidgets[2];
        _selectedAppbar = const FavouriteRecentSearchAppbar(
          text: 'Recent Search',
        );
        break;
    }
    notifyListeners();
  }
}
