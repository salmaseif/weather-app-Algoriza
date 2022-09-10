import 'package:weather_app/data/models/clouds.dart';
import 'package:weather_app/data/models/temperature.dart';
import 'package:weather_app/data/models/weatherDetails.dart';
import 'package:weather_app/data/models/wind.dart';

class WeatherofDay {


  late DateTime date;
  late int visibillity;
  late num precipitation;
  late Temperature temperature;
  late WeatherDetais weatherDetais;
  late Clouds clouds;
  late Wind wind;
  late String dOrn;
  WeatherofDay.fromjson(Map m)
  { this.temperature=Temperature.fromjson(m["main"]);
    this.weatherDetais=WeatherDetais.fromjson(m["weather"][0]);
    this.clouds=Clouds.fromjson(m["clouds"]);
    this.wind=Wind.fromjson(m["wind"]);
    this.visibillity=m["visibility"];
    this.precipitation=m["pop"];
    this.dOrn=m["sys"]["pod"];
    this.date=DateTime.parse(m["dt_txt"]);
  }


}