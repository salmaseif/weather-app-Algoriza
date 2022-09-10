import 'package:weather_app/data/models/coordinates.dart';
class City{
  late int id;
  late String cityname;
  late Coordinates coord;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late int sunset;
  City.fromjson(Map m)
  {
    this.id=m["id"];
    this.cityname=m["name"];
    this.coord=Coordinates.fromjson(m["coord"]);
    this.sunset=m["sunset"];
    this.sunrise=m["sunrise"];
    this.timezone=m["timezone"];
    this.country=m["country"];
    this.population=m["population"];
  }
}
