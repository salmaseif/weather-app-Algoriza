

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/businessLogic/cubit/cubit.dart';
import 'package:weather_app/data/models/currentweathermodel.dart';
import 'package:weather_app/data/repos/currentWeatherRepo.dart';
import 'package:weather_app/data/webServices/weatherWebservices.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';

import 'constants.dart';

// Future<Map> getLoc() async{
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return {};
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return {};
//     }
//   }
//   location.enableBackgroundMode(enable: true);
//   currentPosition = await location.getLocation();
//   print("_currentPosition ${currentPosition}");
//   //_initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
//   location.onLocationChanged.listen((LocationData currentLocation) {
//     print("${currentLocation.longitude} : ${currentLocation.longitude}");
//
//     currentPosition = currentLocation;
//
//     // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
//
//     DateTime now = DateTime.now();
//     // _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//     //_getAddress(_currentPosition.latitude, _currentPosition.longitude)
//     //     .then((value) {
//     //   setState(() {
//     //     _address = "${value.first.addressLine}";
//     //   });
//     // });
//
//   });
//   Map loc={"lat":currentPosition?.latitude,"long":currentPosition?.longitude};
//   print("loc$loc");
//   return  loc;
// }
// late Map locc;
// class AppRouter{
//   late currentWeatherRepo weatherepo;
//   late WeatherCubit weathercubit;
//
//
//   AppRouter(){
//     weatherepo=currentWeatherRepo(CurrentWeatherwebservice());
//    weathercubit=WeatherCubit(weatherepo);
//
//   }
//   // getlocc()async
//   // {
//   //   return await getLoc();
//   // }
//   Route? generateRoute(RouteSettings settings){
//     switch (settings.name){
//     //settings.name is destination file name
//       case mainScreenroute:
//
//
//
//         return MaterialPageRoute(builder: (_)=>BlocProvider(
//           create: (BuildContext context)=>weathercubit,
//
//           child: homeScreen(),
//         ));
//
//
//
//
//     }
//
//
//
//
//   }
//
//
//
//
//
//
//
// }