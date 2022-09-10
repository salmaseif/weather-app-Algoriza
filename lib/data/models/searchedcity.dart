class SearchedCity{
  late String city;
  late String country;
  late var lat;
  late var long;

  SearchedCity.fromjson(Map m)
  {
    this.country=m["country"];
    this.city=m["city_ascii"];
    this.long=m["lng"];
    this.lat=m["lat"];

  }




}