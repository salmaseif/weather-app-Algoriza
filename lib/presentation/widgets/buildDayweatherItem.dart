import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildDayWeatherItem extends StatelessWidget {
  Map day;
  bool isshrink;
  buildDayWeatherItem(
      {Key? key,

        required this.day,
        required this .isshrink
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    Text(
    day["day"],
    style:
     isshrink?
     TextStyle(

    color: Colors.white,
    fontWeight: FontWeight.w500,
    ): TextStyle(

       color: Colors.grey,
       fontWeight: FontWeight.w500,
     ),
    ),
        Row(
          children: [
            Image.asset(
              "assets/images/water.png",
              scale: 0.9,
              width: 17,

            ),
            Text(day["pop"],
              style: TextStyle(
                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 3,
            ),
            Image.asset(
              "assets/images/sun.png",
              scale: 0.9,
              width: 25,
            ),
            SizedBox(
              width: 3,
            ),
            Image.asset(
              "assets/images/moon.png",
              scale: 0.9,
              width: 25,
            ),
            Text(day["mintemp"]
                  .toString(),
              style:
              isshrink?
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ): TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(day["maxtemp"]
                  .toString(),
              style:  isshrink?
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ): TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            )

          ],
        ),

      ],

    );
  }
}
