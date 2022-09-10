import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:weather_app/businessLogic/cubit/cubit.dart';
import 'package:weather_app/businessLogic/cubit/states.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screens/splashScreen.dart';

import 'data/repos/currentWeatherRepo.dart';
import 'data/webServices/weatherWebservices.dart';
// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//
//   return directory.path;
// }
//
// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/counter.txt');
// }
void main() async {

  // final File file = File('C://Users//salma//AndroidStudioProjects//weather_app//lib//worldcities.json'); //load the json file
  // final byteData = await rootBundle.load('assets/$path');
  //
  // final file = File('${(await getTemporaryDirectory()).path}/$path');
  //
  // await readcitiesjson(file);
  //WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}
// Future<List<SearchedCity>?> readcitiesjson (File file) async {
//
//
//   String contents = await file.readAsString();
//   var jsonResponse = jsonDecode(contents);
//
//   for(var p in jsonResponse){
//
//     SearchedCity searchedCity = SearchedCity.fromjson(p);
//     allcities?.add(searchedCity);
//
//   }
//   return allcities;
//
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late currentWeatherRepo weatherepo;
    late WeatherCubit weathercubit;
    weatherepo=currentWeatherRepo(CurrentWeatherwebservice());
    weathercubit=WeatherCubit(weatherepo);
    return MultiBlocProvider(
      providers: [
        BlocProvider(

          create: (BuildContext context)=> weathercubit..getcurrentweather()
        ), ],
      child: BlocConsumer<WeatherCubit,weatherstates>(
          listener: (context,state){},
          builder: (context,state)

          {

            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home:  splashScreen(),
            );}
      ),


    );
  }
}


