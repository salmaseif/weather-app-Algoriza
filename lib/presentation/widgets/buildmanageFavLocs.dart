import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businessLogic/cubit/cubit.dart';
import 'cardcity.dart';

class buildManageFavLocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (BlocProvider
              .of<WeatherCubit>(context)
              .managefavcities
              .isNotEmpty)
            return CardCity(cweather: BlocProvider
                .of<WeatherCubit>(context)
                .managefavcities[index]["cweather"],index: index,isfav:true ,);
          else
            return Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10);
        },
        itemCount: BlocProvider
            .of<WeatherCubit>(context)
            .managefavcities
            .length);
  }
}