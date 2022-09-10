import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businessLogic/cubit/cubit.dart';

class buildDrawerCityItem extends StatelessWidget {

  Map city;
  buildDrawerCityItem(
      {Key? key,

        required this.city
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        onTap: (){
          BlocProvider.of<WeatherCubit>(context).isdrawer=true;
          BlocProvider.of<WeatherCubit>(context)
              .getsearchedforecast(city["cweather"].name.toString().toLowerCase());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(city["cweather"].name,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),

            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,

                  decoration:

                  BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),

                  ),

                ),
                SizedBox(width: 8,),
                Text(city["cweather"].main.temp.toInt().toString()+"°",style: TextStyle(color: Colors.white))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
