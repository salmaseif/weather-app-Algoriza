import 'package:flutter/cupertino.dart';
import 'package:weather_app/presentation/widgets/buildDayweatherItem.dart';

class buildDaysWeather extends StatelessWidget {
  List<Map> daystemp;
  bool isshrink;
  buildDaysWeather(
      {Key? key,

        required this.daystemp,
        required this.isshrink

      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      ListView.separated(
          itemBuilder: (context, index){
            return buildDayWeatherItem(day:daystemp[index],isshrink: isshrink,);

          },
          separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 10);
      },
          itemCount: daystemp.length);
  }
}
