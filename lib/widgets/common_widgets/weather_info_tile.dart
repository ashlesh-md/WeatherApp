import 'package:flutter/material.dart';

class WeatherInformationTile extends StatelessWidget {
  const WeatherInformationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.125),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Udupi , Karnataka',
                style: TextStyle(
                    color: Color.fromRGBO(254, 229, 56, 1),
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '31 °c',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Mostly Sunny',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.favorite,
              size: 28,
              color: Color.fromRGBO(250, 208, 90, 1),
            ),
          )
        ],
      ),
    );
  }
}
