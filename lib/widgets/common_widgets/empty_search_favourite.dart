import 'package:flutter/material.dart';

class EmptySearchFavourite extends StatelessWidget {
  const EmptySearchFavourite({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/splash/icon_nothing.png'),
        const SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
        )
      ],
    );
  }
}
