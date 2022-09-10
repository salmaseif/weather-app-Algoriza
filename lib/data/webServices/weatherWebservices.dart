
import 'package:dio/dio.dart';

class CurrentWeatherwebservice {
  late Dio dio;
  var long;
  var lat;

  CurrentWeatherwebservice( ) {

       print("hi1");


    BaseOptions options = BaseOptions(
      baseUrl: "https://api.openweathermap.org/data/2.5/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //60 secs
      receiveTimeout: 20 * 1000,


    );
    dio = Dio(options);
  }
  Future<Map>  getcurrentweather(String lat, String long) async {
    try {
      print("hiiiii");
      Response response = await dio.get("weather?lat=${lat}&lon=${long}&units=metric&&appid=38fc33dadb6e21b08a92dbb6dd020e50");
      Response response2 = await dio.get("forecast?lat=${lat}&lon=${long}&units=metric&&appid=38fc33dadb6e21b08a92dbb6dd020e50");
      Map weatherresponse={"cweather":response.data,"weather":response2.data};

      print(response.data.toString());
      print(response2.data.toString());
      return weatherresponse;
    }
    catch (e) {
      print("gygygyy");
      print(e.toString());
    }
    return {};
  }
  Future<Map>  getsearchedweather(String cityname) async {
    try {
      print("hiiiii");

      Response response = await dio.get("forecast?q=${cityname}&units=metric&appid=38fc33dadb6e21b08a92dbb6dd020e50");
      Response response2 = await dio.get("weather?q=${cityname}&units=metric&&appid=38fc33dadb6e21b08a92dbb6dd020e50");
      Map weatherresponse={"cweather":response2.data,"weather":response.data};


      return weatherresponse;
    }
    catch (e) {
      print("gygygyy");
      print(e.toString());
    }
    return {};
  }


}