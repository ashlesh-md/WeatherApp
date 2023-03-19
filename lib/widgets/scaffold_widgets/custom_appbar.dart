import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/menu_provider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          'assets/images/splash/logo_splash.png',
          height: 32,
        ),
      ),
      leading: Builder(builder: (ctx) {
        return GestureDetector(
            onTap: () {
              if (Scaffold.of(ctx).isDrawerOpen) {
                Scaffold.of(ctx).closeDrawer();
              } else {
                Scaffold.of(ctx).openDrawer();
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                Icons.menu,
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
              Icons.search,
              size: 32,
            ),
          ),
        )
      ],
    );
  }
}
