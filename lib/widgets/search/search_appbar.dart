import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/menu_provider.dart';

class SearchAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppbar({super.key});

  @override
  State<SearchAppbar> createState() => _SearchAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _SearchAppbarState extends State<SearchAppbar> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                if (textEditingController.text.length > 3) {
                  Provider.of<MenuProvider>(context, listen: false)
                      .setSearchText(text: textEditingController.text);
                }
              });
            },
            decoration: InputDecoration(
                hintText: 'Search for City',
                hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 20,
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
        if (textEditingController.text.length > 3)
          GestureDetector(
            onTap: () {
              Provider.of<MenuProvider>(context, listen: false)
                  .setSearchText(text: '');
              textEditingController.clear();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                color: Colors.black,
                Icons.close,
                size: 32,
              ),
            ),
          )
      ],
    );
  }
}
