import 'package:weather_app/data/models/sys.dart';
import 'package:weather_app/data/models/temperature.dart';
import 'package:weather_app/data/models/weatherDetails.dart';
import 'package:weather_app/data/models/wind.dart';
import 'package:weather_app/data/models/coordinates.dart';
import 'clouds.dart';

class CurrentWeather{
  late Coordinates coord;
  late List<WeatherDetais> weatherdetails=[];
  late String base;
  late Temperature main;
  late int visibility;
  late Wind wind;
  late Clouds clouds;
  late int dt;
  late Sys sys;
  late int timezone;
  late int id;
  late int cod;
  late String name;
  CurrentWeather.fromJson(Map json)
  {
    coord = Coordinates.fromjson(json["coord"]);
    
    weatherdetails = (json["weather"] as List).map((e) => WeatherDetais.fromjson(e)).toList();
    base = json["base"];
    main = Temperature.fromjson(json["main"]);
    visibility = json["visibility"];
    wind=Wind.fromjson(json['wind']);
    clouds = Clouds.fromjson(json["clouds"]);
    dt = json["dt"];
    sys = Sys.fromjson(json["sys"]);
    timezone = json["timezone"];
    id = json["id"];
    cod = json["cod"];
    name = json["name"];


  }






}