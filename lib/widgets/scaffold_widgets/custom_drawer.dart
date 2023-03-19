import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/menu_items.dart';
import '../../providers/menu_provider.dart';

class CustomDrawer extends Drawer {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Drawer(
        child: DrawerHeader(
      padding: const EdgeInsets.all(30),
      child: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                menuProvider.changeMenu(menu: MenuItems.home);
                Scaffold.of(context).closeDrawer();
              },
              child: Text(
                'Home',
                style: TextStyle(
                    fontSize:
                        menuProvider.selectedMenu == MenuItems.home ? 20 : 18,
                    color: menuProvider.selectedMenu == MenuItems.home
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                menuProvider.changeMenu(menu: MenuItems.favourite);
                Scaffold.of(context).closeDrawer();
              },
              child: Text(
                'Favourite',
                style: TextStyle(
                    fontSize: menuProvider.selectedMenu == MenuItems.favourite
                        ? 20
                        : 18,
                    color: menuProvider.selectedMenu == MenuItems.favourite
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                menuProvider.changeMenu(menu: MenuItems.recentSearch);
                Scaffold.of(context).closeDrawer();
              },
              child: Text(
                'Recent Search',
                style: TextStyle(
                    fontSize:
                        menuProvider.selectedMenu == MenuItems.recentSearch
                            ? 20
                            : 18,
                    color: menuProvider.selectedMenu == MenuItems.recentSearch
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        );
      }),
    ));
  }
}
