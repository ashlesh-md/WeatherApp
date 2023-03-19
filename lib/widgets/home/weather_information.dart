import 'package:flutter/material.dart';

class WeatherInformation extends StatelessWidget {
  const WeatherInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.sunny, color: Colors.white, size: 100),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '31',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 17),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        border: Border.all(color: Colors.white)),
                    child: const Text(
                      '°C ',
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    ),
                  ),
                  Container(
                    width: 35,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: const Text(
                      '°F ',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Mostly Sunny',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }
}
