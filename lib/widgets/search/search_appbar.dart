import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/menu_provider.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Search for City',
                hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          )),
      leading: Builder(builder: (ctx) {
        return GestureDetector(
            onTap: () {
              Provider.of<MenuProvider>(context, listen: false)
                  .changeSearchStatus();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 32,
              ),
            ));
      }),
      actions: [
        GestureDetector(
          onTap: () {
            // Provider.of<MenuProvider>(context, listen: false)
            //     .changeSearchStatus();
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
