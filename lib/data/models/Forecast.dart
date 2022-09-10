import 'City.dart';
import 'weatherofday.dart';

class Forecast
{
 late List<WeatherofDay>allList;
 late City city;


 Forecast.fromJson(Map m)
 {
  this.allList=(m["list"] as List).map((e) =>WeatherofDay.fromjson(e)).toList();
  this.city=City.fromjson(m["city"]);




 }

}

