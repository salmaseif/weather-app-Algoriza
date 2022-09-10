class Wind{
  late var speed;
  late var deg;
  late var gust;
  Wind.fromjson(Map m)
  {
    this.speed=m["speed"];
    this.deg=m["deg"];
    this.gust=m["gust"];


  }



}