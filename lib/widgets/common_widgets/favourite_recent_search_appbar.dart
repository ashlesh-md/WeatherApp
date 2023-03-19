import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/menu_items.dart';
import 'package:weather_app/providers/menu_provider.dart';

class FavouriteRecentSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const FavouriteRecentSearchAppbar({super.key, required this.text});
  final String text;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      leading: Builder(builder: (ctx) {
        return GestureDetector(
            onTap: () {
              Provider.of<MenuProvider>(context, listen: false)
                  .changeMenu(menu: MenuItems.home);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                color: Colors.black,
                Icons.arrow_back,
                size: 32,
              ),
            ));
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Provider.of<MenuProvider>(context, listen: false)
                .changeSearchStatus();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(
              color: Colors.black,
              Icons.search,
              size: 32,
            ),
          ),
        )
      ],
    );
  }
}
