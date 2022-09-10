import 'package:flutter/cupertino.dart';
import 'package:weather_app/data/models/Forecast.dart';
import 'package:weather_app/data/models/currentweathermodel.dart';
import 'package:weather_app/data/models/searchedcity.dart';

import '../webServices/weatherWebservices.dart';

class currentWeatherRepo{
  // currentWeatherRepo(this.long,this.lat, this.currentWeatherwebservice);
  // String long;
  // String lat;
  final CurrentWeatherwebservice weatherWebService;

  currentWeatherRepo(this.weatherWebService);



  Future<Map> getcurrentweather(String lat,String long)async{
    Map? currentWeather;
    Map? totalWeather;
    Map resp=await weatherWebService.getcurrentweather(lat, long);

    currentWeather = resp["cweather"];
    totalWeather=resp["weather"];
     Map result= {"current":CurrentWeather.fromJson(currentWeather!),"all":Forecast.fromJson(totalWeather!)};
    return result;



  }

  Future<Map> getsearchedweather(String cityname)async{
    Map? currentWeather;
    Map? totalWeather;
    Map resp=await weatherWebService.getsearchedweather(cityname);
    currentWeather = resp["cweather"];
    totalWeather=resp["weather"];
    print("resp in j ${resp}");
    return {"current":CurrentWeather.fromJson(currentWeather!),"all":Forecast.fromJson(totalWeather!)};



  }



}