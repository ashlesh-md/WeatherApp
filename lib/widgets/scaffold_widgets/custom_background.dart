import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash/background_android.png',
                  ),
                  fit: BoxFit.fill)),
        ),
        Container(
          color: Colors.transparent,
          child: child,
        )
      ],
    );
  }
}
