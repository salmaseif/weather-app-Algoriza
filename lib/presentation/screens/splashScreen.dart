import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import '../../businessLogic/cubit/cubit.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
Future.delayed( Duration(seconds: 6)).then((value) =>
   {
   Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => homeScreen() ))
   }
    );



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff955cd1),
                  Color(0xff3fa2fa),

                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.2,0.85]

            )
        ),
        width: double.infinity,
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/weatherlogo.png", width: 200,),

            Text("Weather App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
            SizedBox(height: 10,),
            SpinKitThreeInOut(
           color: Colors.blueAccent,

              size: 40.0,

            )

          ],

        ),),
      ),


    );
  }
}
