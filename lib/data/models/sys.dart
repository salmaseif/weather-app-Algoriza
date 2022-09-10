class Sys
{
  //late int type;
  //late int id;
  late int sunrise;
  late int sunset;
  late String country;
 Sys.fromjson(Map m)
 {

   this.country=m["country"];
   this.sunrise=m["sunrise"];
   this.sunset=m["sunset"];


 }



}