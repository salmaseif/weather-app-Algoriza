import 'package:intl/intl.dart';
import 'package:weather_app/data/models/currentweathermodel.dart';
import 'package:weather_app/data/models/searchedcity.dart';

import '../../data/models/Forecast.dart';
import '../../data/models/weatherofday.dart';

int getAverage(List e)
{
  double sum=0;
  for(int i=0;i<e.length;i++)
  {
    sum=e[i]+sum;
  }
  print("fromavg");
  return (sum/e.length).toInt();
}
abstract class weatherstates {}
class initialweatherstate extends weatherstates{}
class locchangedstate extends weatherstates{


}
class locccurrentstate extends weatherstates{

  List<String>timestoday=[];
  List<num>temptoday=[];
  List<String> preception=[];
  List<Map>daystemp=[];

  late Forecast searchedcityforecast;

  locccurrentstate(this.searchedcityforecast,this.daystemp,this.preception,this.temptoday,this.timestoday);
}
class searchedCitiesState extends weatherstates{
  final List<SearchedCity> searchedcites;

  searchedCitiesState(this.searchedcites);

}
class searchedCityState extends weatherstates{


}
class startsearchState extends weatherstates{


}
class stopsearchState extends weatherstates{




}
class clearsearchCharactersState extends weatherstates{




}
class updatecity extends weatherstates{

  List<WeatherofDay>today=[];
  List<String>timestoday=[];
  List<num>temptoday=[];
  List<String> preception=[];
  List<Map>daystemp=[];
  CurrentWeather cweather;
  late Forecast searchedcityforecast;

  updatecity(this.searchedcityforecast,this.cweather,this.daystemp,this.preception,this.temptoday,this.timestoday,this.today);



}
class deletecity extends weatherstates{





}
class updatefavcity extends weatherstates{





}