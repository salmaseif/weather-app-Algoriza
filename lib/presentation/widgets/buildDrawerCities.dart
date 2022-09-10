import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/widgets/buildDrawerCityItem.dart';

import '../../businessLogic/cubit/cubit.dart';

class buildDrawerCities extends StatelessWidget {
  List<Map> cities;
  buildDrawerCities(this.cities);
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (context, index) {

          return   buildDrawerCityItem(city: cities[index],);

        },
        separatorBuilder: (BuildContext context, int index) {
          return Column(children: [
              SizedBox(height: 10),
            Divider(color: Colors.white24,)

          ],);
        },
        itemCount: cities
            .length);
  }
}
