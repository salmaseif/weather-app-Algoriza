import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/businessLogic/cubit/cubit.dart';
import 'package:weather_app/data/constants.dart';

import '../../data/models/currentweathermodel.dart';

class CardCity extends StatelessWidget {

  CurrentWeather cweather;
  int index;
  bool isfav;

  CardCity(
      {Key? key,

        required this.cweather,
        required this.index,
        required this.isfav
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(cweather!=null)
    return Dismissible(
      onDismissed: (direction){ BlocProvider.of<WeatherCubit>(context).deleteCityWeather(index,isfav);},
      background:buildSwipeActionRight() ,
      key:  UniqueKey(),
      child: Container(

       padding: EdgeInsets.all(7),
        height: 130,
        decoration:  BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Icon(Icons.location_on),
                        Text(cweather.name),



                      ],
                    ),
                    Center(child: Text(allcitiescodes[cweather.sys.country])),
                   Center(
                     child: Text( "${DateFormat('EE').format(DateTime.now()).toString()}, ${DateFormat( 'MMM').format(DateTime.now()).toString()}"
                         " ${DateTime.now().day}"
                         " ,${DateFormat.jm().format(DateTime.now())}"),
                   )
                  ],
                ),

                Column(
                  children: [
                    IconButton(color: Colors.red,icon:
                   isfav==false?
                    Icon(Icons.favorite_border):
                    Icon(Icons.favorite), onPressed: () {
                      if(isfav==false)
                       {
                         print("fav");
                         BlocProvider.of<WeatherCubit>(context).updatefav(index, true);}
                      else

                 {
                   print("unfav");
                   BlocProvider.of<WeatherCubit>(context).updatefav(index, false);}

                    },),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/moon.png",
                          height: 25,
                          width: 20,
                        ),
                        Text(cweather.main.temp.toInt().toString()+"°")

                      ],
                    ),
                    Text(cweather.main.temp_max.toInt().toString()+"/"+cweather.main.temp_min.toInt().toString()),

                  ],


                )


              ],

            )

          ],


        ),

      ),
    );
    else return CircularProgressIndicator();
  }
  Widget buildSwipeActionRight() => Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
  );
}
