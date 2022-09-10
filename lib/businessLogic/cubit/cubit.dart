
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/businessLogic/cubit/states.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/data/models/Forecast.dart';
import 'package:weather_app/data/models/searchedcity.dart';
import 'package:weather_app/data/models/weatherofday.dart';
import 'package:weather_app/data/repos/currentWeatherRepo.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/currentweathermodel.dart';
import '../../data/webServices/weatherWebservices.dart';
//import 'package:location/location.dart';
class WeatherCubit extends Cubit<weatherstates>

{
  static WeatherCubit get(context)=>BlocProvider.of(context);
   currentWeatherRepo currentrepo;

  List<SearchedCity>? seacrchedcities;
  Future<List<SearchedCity>?> readcitiesjson (File file) async {


    String contents = await file.readAsString();
    var jsonResponse = jsonDecode(contents);

    for(var p in jsonResponse){

      SearchedCity searchedCity = SearchedCity.fromjson(p);
      seacrchedcities?.add(searchedCity);

    }
    return seacrchedcities;

  }
List <SearchedCity>allcitiess=[];
  Map loc={};
  bool issearch=false;
  String searchedcity="";
 List<Map> managecities=[];
  List<Map> managefavcities=[];

  CurrentWeather? ccityweather;
  List<SearchedCity> searchedcitiesdata=[];
  List<SearchedCity> searchedcities=[];
  List<DateTime> alldates=[];

  List<WeatherofDay>today=[];

  List<String>timestoday=[];
  List<num>temptoday=[];
  List<String> preception=[];
  List<Map>daystemp=[];
  bool isdrawer=false;
  bool issearchinmain=false;
  DateTime tom=DateTime.now().add(Duration(days: 1)); //4
  DateTime tom2=DateTime.now().add(Duration(days: 2)); //5
  DateTime tom3=DateTime.now().add(Duration(days: 3)); //6
  DateTime tom4=DateTime.now().add(Duration(days: 4)); //7
  DateTime tom5=DateTime.now().add(Duration(days: 5)); //8
  WeatherCubit(this.currentrepo) : super(initialweatherstate());
  final searchController=TextEditingController ();
  //Location location = Location();
  //LocationData? currentPosition;

  String cityname="";
  CurrentWeather? cweather;
  Forecast? forecast;
  Forecast? searchedforecast;
  List<Forecast> citiesforecast=[];
getcurrentweather()async
{
  getLoc().then((value)
  {

    loc=value;
    CurrentWeatherwebservice?  currentWeatherwebservice=  CurrentWeatherwebservice();
    currentrepo=  currentWeatherRepo(currentWeatherwebservice) ;

    currentrepo.getcurrentweather(loc["lat"],loc["long"]).then((value)

  {  this.cweather=value["current"];

  this.forecast=value["all"];
  // managefavcities.add(
  //     { "cweather":this.cweather,
  //       "forecast":this.forecast,
  //       "isfav":true
  //     }

  //);
this.preception.clear();
this.timestoday.clear();
  this.temptoday.clear();
  this.today.clear();
  this.daystemp.clear();
  print("forecast ${this.forecast}");
  gettodaytimestemplist(this.forecast!,this.preception,this.temptoday,this.timestoday,this.today,this.daystemp);
  emit(locccurrentstate(this.forecast!,daystemp,preception,temptoday,timestoday));


  });


  }

  );

  //loc={"lat":currentPosition?.latitude,"long":currentPosition?.longitude};



}

gettodaytimestemplist(Forecast forecast,List<String> precep, List<num> temptoday ,List<String> timestoday,List<WeatherofDay>today,
    List<Map >daystemp
    )
{
  //daystemp=[]
  List<List<WeatherofDay>> daytimes=[];
  List<WeatherofDay> days=[];
  print("lolo");
   DateFormat formatter = DateFormat('yyyy-MM-dd');
  print("lolo2");
   String formatted = formatter.format(DateTime.now().add(Duration(days: 1)));
  print("lolo3");
  forecast.allList.map((e)  {
    print("lolo4");
    DateFormat formatter2 = DateFormat('yyyy-MM-dd');
      days.add(e);
    String formatted2 = formatter2.format(e.date);
    if (formatted2==formatted) {
      print("okkkkkkkkkk");
      today.add(e);



      timestoday.add(DateFormat.j().format(e.date));

      temptoday.add(e.temperature.feels_like);

      precep.add("${e.precipitation.toStringAsFixed(1)}%");
    }


print("okkkkkkkkkkk");


  }).toList();
int j=0;
  days=days.toSet().toList();
  print("daysss${days.length}");
  for(int i=0; i<days.length-1;i++)
    {
      List<WeatherofDay> ss=[];
      ss.add(days[i]);
      for( j=i+1; j<days.length;j++)
        {
          print("daytt${days[i].date.day}");
          if(days[i].date.day==days[j].date.day)
            {
            ss.add(days[j]);
              print("uui");
              days.removeAt(j);
              j--;
            }

          print("jr$j");
        }

      daytimes.add(ss);

    }
  print("bbhbhbh$j");
  List<WeatherofDay> ff =[days[j-1]];
  daytimes.add(ff);


  print("days$days");

print("daytimes${daytimes.map((e) => e.map((e) => e.date).toList()).toList()}");
print("temptoday${temptoday.length}");
  List<List<num>> maxtimes=daytimes.map((e) => e.map((e) =>e.temperature.temp_max ).toList()).toList();
  List<List<num>> mintimes=daytimes.map((e) => e.map((e) =>e.temperature.temp_min ).toList()).toList();
  print("maxtimes${maxtimes[0]}");
  List<num>minn=mintimes.map((e) => e.reduce(min).toInt()).toList();
  List<num>maxx=maxtimes.map((e) => e.reduce(max).toInt()).toList();
  print("ll${minn[0]}");
  print("maxti${maxtimes.length}");
  print("maxti${maxtimes.length}");
  // List avgmin=mintimes.map((e) =>getAverage(e)).toList();
  // List avgmax=maxtimes.map((e) =>getAverage(e)).toList();

  print("length days");
print(days.length);

//   print("length days");
// print(mintempalldays.length);
//   print("length days");
//   print(maxtempalldays.length);
//   print("avg ${avgmin.length}");
//   print("avg ${avgmax.length}");
for(int i=0; i<days.length;i++)
  {


    daystemp.add(
        {
          "day":  DateFormat('EEEE').format(days[i].date).toString()==DateFormat('EEEE').format(DateTime.now()).toString()?
          "Today": DateFormat('EEEE').format(days[i].date).toString(),
          "mintemp":minn[i].toString(),"maxtemp":maxx[i].toString(),
          "pop":days[i].precipitation.toDouble() .toStringAsFixed(1).toString()+"%"

        }
    );
  }

   print("nooooo");


}

 getsearchedforecast(String? city)
{
  List<WeatherofDay>today=[];
 List<String> preceptionn=[];
 List<String>timestoday=[];
 List<num>temptoday=[];
  List<Map>daysstemp=[];
  CurrentWeatherwebservice?  currentWeatherwebservice=  CurrentWeatherwebservice();
  currentrepo=  currentWeatherRepo(currentWeatherwebservice) ;
  print("city:$city");
  currentrepo.getsearchedweather(city!).then((value)
  {
    this.ccityweather=value["current"];
  this.searchedforecast=value["all"];

  gettodaytimestemplist(searchedforecast!,preceptionn,temptoday,timestoday,today,daysstemp);
  if(isdrawer==false&&issearchinmain==false)
 { managecities.add(
    { "cweather":this.ccityweather,
      "forecast":this.searchedforecast,
      "isfav":false
    }

  );}

  issearchinmain=false;
  isdrawer=true;
  emit(updatecity(this.searchedforecast!,this.ccityweather!,daysstemp,preceptionn,temptoday,timestoday,today));
  });



}
 List<SearchedCity> searchedfunc(String searchedCity) {
  //searchedcitiesdata= allcitiess.map((e) => SearchedCity.fromjson(e)).toList();
    searchedcities=searchedcitiesdata.where((e) => e.city.toLowerCase().startsWith(searchedCity)).toList();

    emit(searchedCitiesState(this.searchedcities));
    return this.searchedcities;
  }
  updatefav(int id ,bool isfav)
  {
    if(isfav)
      {
      this.managefavcities.add(   { "cweather":managecities[id]["cweather"],
        "forecast":managecities[id]["forecast"],
        "isfav":true
      });
      print("yyyyyyyyy2");
      this.managecities.removeAt(id);
      print(managefavcities[0]["cweather"].name);
      emit(updatefavcity());

      }
    else if(isfav==false)

    {this.managecities.add({ "cweather":managefavcities[id]["cweather"],
      "forecast":managefavcities[id]["forecast"],
      "isfav":false
    });
    print("yyyyyyyyy");
    print(managefavcities.length);

    print(id);
    this.managefavcities.removeAt(id);
    emit(updatefavcity());

    }

    emit(updatefavcity());

  }
  void startsearch(BuildContext context)
  {  issearch=true;
  ModalRoute.of(context)!
      .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopsearch));

  }
  void stopsearch()
  { issearch=false;
  clearsearch();
  emit(stopsearchState());

  }
  void clearsearch()
  {
    searchController.clear();
    searchedcity="";
    emit(clearsearchCharactersState());
  }

  Future<Map>  getLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position cposition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position? position) {
          print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
           cposition=position!;
          emit(locchangedstate());
        });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Map loc={"lat":cposition.latitude.toString(),"long":cposition.longitude.toString()};
    print("$loc"+"loc");

    return loc;
  }
deleteCityWeather(int index, bool isfav)
{
 if(isfav)
   managefavcities.removeAt(index);
 else
  managecities.removeAt(index);
  emit(deletecity());
}






}