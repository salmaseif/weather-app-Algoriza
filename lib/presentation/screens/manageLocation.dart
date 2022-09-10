import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/presentation/widgets/buildManageLocs.dart';
import 'package:weather_app/presentation/widgets/cardcity.dart';

import '../../businessLogic/cubit/cubit.dart';
import '../../businessLogic/cubit/states.dart';
import '../../data/models/currentweathermodel.dart';
import '../widgets/buildmanageFavLocs.dart';

class manageLocScreen extends StatefulWidget {
  CurrentWeather cweather;
  manageLocScreen(
      {Key? key,

        required this.cweather,

      })
      : super(key: key);
  @override
  _manageLocScreenState createState() => _manageLocScreenState();
}

class _manageLocScreenState extends State<manageLocScreen> {
  Widget buildSearchField() {
    return Container(
      width: 150,
      child: TypeAheadFormField(
        animationStart: 0,
        animationDuration: Duration.zero,
        textFieldConfiguration: TextFieldConfiguration(
            controller: BlocProvider.of<WeatherCubit>(context).searchController,
            autofocus: true,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(border: OutlineInputBorder())),
        suggestionsBoxDecoration:
        SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
        suggestionsCallback: (pattern) {
          List<String> matches = <String>[];
        //  print("lengthhhhhhhhh${allcities.length} ");
          matches.addAll(BlocProvider.of<WeatherCubit>(context)
              .allcitiess
              .map((e) => e.city)
              .toList());

          matches.retainWhere((s) {
            return s.toLowerCase().contains(pattern.toLowerCase());
          });
          return matches;
        },
        itemBuilder: (context, sone) {
          return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(sone.toString()),
              ));
        },
        onSuggestionSelected: (suggestion) {
          BlocProvider.of<WeatherCubit>(context).isdrawer=false;
          BlocProvider.of<WeatherCubit>(context).issearchinmain=false;
          BlocProvider.of<WeatherCubit>(context).searchController.text =
              suggestion.toString();
          BlocProvider.of<WeatherCubit>(context).searchedcity =
              suggestion.toString();
          print("biiiii${suggestion.toString().toLowerCase()}");
          BlocProvider.of<WeatherCubit>(context)
              .getsearchedforecast(suggestion.toString().toLowerCase());
        },
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 60),
      child:BlocBuilder<WeatherCubit, weatherstates>(builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
        //backgroundColor: Colors.cyan,
        body:   SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: Text("Manage locations", style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocProvider
                          .of<WeatherCubit>(context)
                          .issearch ?
                      Expanded(child: buildSearchField()) :
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios)),
                      BlocProvider
                          .of<WeatherCubit>(context)
                          .issearch==true?
                      IconButton(onPressed: () {
                        if (BlocProvider
                            .of<WeatherCubit>(context)
                            .searchController
                            .text
                            .isEmpty) {
                          BlocProvider.of<WeatherCubit>(context).clearsearch();

                          Navigator.pop(context);
                        } else
                          BlocProvider.of<WeatherCubit>(context).clearsearch();
                      }, icon: Icon(Icons.clear)) :

                      IconButton(onPressed: () {
                        BlocProvider.of<WeatherCubit>(context).startsearch(context);
                        setState(() {

                        });
                      },

                          icon: Icon(Icons.add)),

                    ],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Favorite location"),
                      Icon(Icons.info_outline_rounded),

                    ],

                  ),
                  SizedBox(height: 15,),
                   CardCity(cweather: BlocProvider.of<WeatherCubit>(context).cweather!,index: 1,isfav: true,),
                  buildManageLocs(cities:BlocProvider
                      .of<WeatherCubit>(context)
                      .managefavcities),
                  // CardCity(cweather: BlocProvider.of<WeatherCubit>(context).managefavcities[0]["cweather"],index: 1,isfav: true,),
                  SizedBox(height: 2,),
                  Divider(),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Other locations"),
                      Text("swipe left to delete",style: TextStyle(color: Colors.red.shade900,fontSize: 10),)
                    ],
                  ),

                  buildManageLocs(cities:BlocProvider
                      .of<WeatherCubit>(context)
                      .managecities),
                  SizedBox(height: 50,)


                ],

              ),
            ));

          }) );


      }
      

  }

