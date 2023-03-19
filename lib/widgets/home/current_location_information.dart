import 'package:flutter/material.dart';

class CurrentLocationInformation extends StatelessWidget {
  const CurrentLocationInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'WED , 28 NOV 2018   11:35 AM',
          style: TextStyle(
              letterSpacing: 2,
              color: Colors.grey.shade100,
              fontSize: 17,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 15),
        const Text(
          'Udupi, Karnataka',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 10),
            Text(
              'Add to favourite',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            )
          ],
        )
      ],
    );
  }
}
