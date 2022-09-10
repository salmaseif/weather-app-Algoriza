class Temperature
{
  late num temp;
  late num feels_like ;
  late num temp_min;
  late num temp_max;
 late int pressure;
  late int humidity;
  //late int sea_level;
  //late int grnd_level;


  Temperature.fromjson(Map m)
  {
    this.temp=m["temp"];
    this.feels_like=m["feels_like"];
    this.temp_min=m["temp_min"];
    this.temp_max=m["temp_max"];
    this.pressure=m["pressure"];
    this.humidity=m["humidity"];
    //this.sea_level=m["sea_level"];
    //this.grnd_level=m["grnd_level"];


  }





}