class WeatherDetais
{
  late int  id;
  late String main;
  late String description;
  late String icon;

WeatherDetais.fromjson(Map m)
{
  this.id= m["id"];
  this.main= m["main"];
  this.icon= m["icon"];
  this.description=m["description"];
}

}