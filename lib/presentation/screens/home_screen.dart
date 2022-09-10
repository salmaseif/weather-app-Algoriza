import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';

import 'package:lottie/lottie.dart';
import 'package:weather_app/businessLogic/cubit/states.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/data/models/currentweathermodel.dart';
import 'package:weather_app/presentation/widgets/buildDaysWeather.dart';
import 'package:weather_app/presentation/widgets/buildDrawerCities.dart';
import 'package:weather_app/presentation/widgets/menu_button.dart';
import 'package:weather_app/presentation/widgets/navigationDrawer.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:weather_app/presentation/widgets/cardcity.dart';
import '../../businessLogic/cubit/cubit.dart';
import '../../constants.dart';
import '../../data/models/searchedcity.dart';
import '../../data/models/weatherofday.dart';
import '../../data/repos/currentWeatherRepo.dart';
import '../../data/webServices/weatherWebservices.dart';
import '../widgets/sliderdrawer.dart';
import 'manageLocation.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
List<Text> times = [
  Text(
    "3 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "4 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "5 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "6 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "7 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "8 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "9 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "10 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "11 pm",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
];

List<Text> small = [
  Text(
    "24",
    style: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "24",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
];
List<Text> days = [
  Text(
    "yesterday",
    style: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
  ),
  Text(
    "Today",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "monday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "Tuesday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "wedensday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "Thursday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "Friday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "saturday",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
];
List<Text> large = [
  Text(
    "34",
    style: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
  ),
  Text(
    "35",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "37",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "34",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "35",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "34",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "34",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
  Text(
    "34",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  ),
];
var data = [34.0, 24.0, 33.0, 33.0, 32.0, 34.0, 24.0, 25.0, 34.0];
var humdity = [
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  ),
  Text(
    "0%",
    style: TextStyle(
        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
  )
];

class homeScreen extends StatefulWidget {
  // final Weather weather;

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  //LocationData? _currentPosition;
  Widget buildSearchField() {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(top: 20,bottom: 15),
      child: TypeAheadFormField(
        animationStart: 0,

        animationDuration: Duration.zero,
        textFieldConfiguration: TextFieldConfiguration(

          cursorColor: Colors.white,
            controller: BlocProvider.of<WeatherCubit>(context).searchController,
            autofocus: true,
            style: TextStyle(fontSize: 15,color: Colors.white),
            decoration: InputDecoration(
                hoverColor: Colors.white,
                border: OutlineInputBorder())),
        suggestionsBoxDecoration:
            SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
        suggestionsCallback: (pattern) {
          List<String> matches = <String>[];
          print("lengthhhhhhhhh${allcities?.length} ");
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
          BlocProvider.of<WeatherCubit>(context).issearchinmain=true;
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
    //   return TextField(
    //
    //    controller:  BlocProvider.of<WeatherCubit>(context).searchController,
    //    cursorColor: Colors.white,
    //     decoration: InputDecoration(
    //
    //        hintText: "Find a City",
    //         border: InputBorder.none,
    //         hintStyle: TextStyle(color: Colors.white,fontSize: 18),
    //
    //     ),
    //    style: TextStyle(color: Colors.white,fontSize: 18),
    //     onChanged: (searchedCharacter){
    //       BlocProvider.of<WeatherCubit>(context).searchedfunc(searchedCharacter);
    //
    //
    //    },
    // onTap: (){
    //
    //
    //
    // },
    //
    //
    // );
  }

  List<Widget> buildAppbaractions() {
    if (BlocProvider.of<WeatherCubit>(context).issearch) {
      return [
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            if (BlocProvider.of<WeatherCubit>(context)
                .searchController
                .text
                .isEmpty) {
              BlocProvider.of<WeatherCubit>(context).clearsearch();

              Navigator.pop(context);
            } else
              BlocProvider.of<WeatherCubit>(context).clearsearch();
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<WeatherCubit>(context).startsearch(context);
          },
        )
      ];
    }
  }

  String? _address, _dateTime;

  //Location location = Location();
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  Map? currentloc;
  late String currentlocation;
  Widget buildSliverAppbar(
      String desc,
      String city,
      String maintemp,
      String mintemp,
      String maxtemp,
      String feelslike,
      List<String> preception,
      List<num> temptoday,
      List<String> timestoday,
      List<WeatherofDay> today) {
    return SliverAppBar(
        leading: BlocProvider.of<WeatherCubit>(context).issearch
            ? BackButton(
                color: Colors.white,
              )
            : IconButton(onPressed: (){

          _key.currentState?.toggle();


              }, icon:Icon( Icons.menu,size: 25,)),
        title: BlocProvider.of<WeatherCubit>(context).issearch
            ? buildSearchField()
            : Container(),
        actions: buildAppbaractions(),
        expandedHeight: 340,
        elevation: 0.0,
        backgroundColor:isShrink? Colors.black:Color(0XFF87a5e1),
        pinned: true,
        stretch: true,
        collapsedHeight: 230.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,

          collapseMode: CollapseMode.none,
          title: isShrink
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, top: 70, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Text(
                            city,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        //  mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Text(
                            maintemp+ "°",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.w300),
                          )),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${maxtemp}°/${mintemp}°\n"
                                  "${DateFormat('EEEE').format(DateTime.now()).toString()} ${DateFormat.jm().format(DateTime.now())}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Lottie.asset(
                            "assets/animations/sun.json",
                            width: 110,
                          )),
                        ],
                      ),
                      Row(

                        children: [
                          Image.asset("assets/images/cloud.png",width: 25,),
                          SizedBox(width: 4,),
                          Text(desc,style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 150,
                ),
          background: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      //  mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          maintemp + "°",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.w300),
                        ),
                        Lottie.asset(
                          "assets/animations/sun.json",
                          width: 110,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          city,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/cloud.png",width: 22,),
                        SizedBox(width: 2,),
                        Text(desc,style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        ),
                      ],
                    ),
                    Text(
                      "${maxtemp}°/${mintemp}°"
                      " Feels Like ${feelslike}° "
                      "\n"
                      "${DateFormat('EEEE').format(DateTime.now()).toString()}, ${DateFormat.jm().format(DateTime.now())}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                    //SizedBox(height: 50,)
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.4),
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: Border.all(
                    //       color: Colors.white.withOpacity(0.5),
                    //       width: 1.0,
                    //       style: BorderStyle.solid,
                    //     ),
                    //   ),
                    //   width: double.infinity,
                    //   height: 200,
                    //   //margin: EdgeInsets.only(left: 20,right: 15),
                    //   // padding: EdgeInsets.symmetric(horizontal: 10.0),
                    //   //padding: EdgeInsets.only(left: 5,),
                    //   child: ListView(
                    //       scrollDirection: Axis.horizontal,
                    //       shrinkWrap: true,
                    //       children: [
                    //         Container(
                    //           width: 400,
                    //           child: Column(children: [
                    //             Expanded(
                    //               child: Container(
                    //                 //height: 100,
                    //                 padding: EdgeInsets.only(top: 13, left: 15),
                    //                 child: ListView.separated(
                    //                   // shrinkWrap: true,
                    //                   scrollDirection: Axis.horizontal,
                    //                   itemCount: timestoday.length,
                    //                   itemBuilder: (context, index) {
                    //                     return Column(
                    //                       children: [
                    //                         Text(
                    //                           timestoday[index],
                    //                           style: const TextStyle(
                    //                               color: Colors.white,
                    //                               fontSize: 11,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         const SizedBox(
                    //                           height: 2,
                    //                         ),
                    //                         if (today[index].dOrn == "d")
                    //                           Image.asset(
                    //                             "assets/images/sun.png",
                    //                             width: 30,
                    //                           )
                    //                         else
                    //                           Image.asset(
                    //                             "assets/images/moon.png",
                    //                             height: 30,
                    //                             width: 25,
                    //                           ),
                    //                       ],
                    //                     );
                    //                   },
                    //                   separatorBuilder:
                    //                       (BuildContext context, int index) {
                    //                     return const SizedBox(
                    //                       width: 27,
                    //                     );
                    //                   },
                    //                   //     children: [
                    //                   //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                    //                   //       SizedBox(height: 2,),
                    //                   //       Image.asset("assets/images/sun.png",scale: 1.6,),
                    //                   //     ],
                    //                   //   ),
                    //                   //   SizedBox(height: 30,),
                    //                   //   Sparkline(
                    //                   //
                    //                   //   //  gridLineAmount: 100,
                    //                   //     min: -50,
                    //                   //      max: 50,
                    //                   //
                    //                   //    pointIndex: 19,
                    //                   //     // gridLineWidth: 50,
                    //                   //     gridLineWidth:50,
                    //                   //       //sharpCorners: true,
                    //                   //       gridLineColor: Colors.white,
                    //                   //     //  kLine: ['max', 'min', 'first', 'last'],
                    //                   //      // fallbackWidth: 100,
                    //                   //
                    //                   //       lineColor: Colors.white,
                    //                   //       pointSize: 4,
                    //                   //       pointsMode: PointsMode.all,
                    //                   //       pointColor: Colors.white,
                    //                   //       //gridLineWidth: 10,
                    //                   //       //averageLabel: true,
                    //                   //     //  gridLineAmount: 5,
                    //                   //       data: data)
                    //                   //
                    //                   // ],
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 20,
                    //             ),
                    //             Expanded(
                    //               child: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     left: 30, right: 15, top: 15),
                    //                 child: Sparkline(
                    //
                    //                     //  gridLineAmount: 100,
                    //                     min: -50,
                    //                     max: 50,
                    //                     gridLineAmount: 5,
                    //                     pointIndex: 1,
                    //                     //gridLineWidth: 50,
                    //                     // gridLineWidth:50,
                    //                     //sharpCorners: true,
                    //                     gridLineColor: Colors.white,
                    //                     //  kLine: ['max', 'min', 'first', 'last'],
                    //                     // fallbackWidth: 100,
                    //
                    //                     lineColor: Colors.white,
                    //                     pointSize: 4,
                    //                     pointsMode: PointsMode.all,
                    //                     pointColor: Colors.white,
                    //                     //gridLineWidth: 10,
                    //                     //averageLabel: true,
                    //                     //  gridLineAmount: 5,
                    //                     data: temptoday
                    //                         .map((e) => e.toDouble())
                    //                         .toList()),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               child: Container(
                    //                 //height: 100,
                    //                 padding: EdgeInsets.only(top: 5, left: 23),
                    //                 child: ListView.separated(
                    //                   //shrinkWrap: true,
                    //                   physics: NeverScrollableScrollPhysics(),
                    //
                    //                   scrollDirection: Axis.horizontal,
                    //                   itemCount: preception.length,
                    //                   itemBuilder: (context, index) {
                    //                     return Row(
                    //                       children: [
                    //                         Image.asset(
                    //                           "assets/images/water.png",
                    //                           scale: 0.9,
                    //                           width: 17,
                    //                         ),
                    //                         Text(
                    //                           preception[index],
                    //                           style: TextStyle(
                    //                               color: Colors.white,
                    //                               fontSize: 11,
                    //                               fontWeight: FontWeight.bold),
                    //                         )
                    //                       ],
                    //                     );
                    //                   },
                    //                   separatorBuilder:
                    //                       (BuildContext context, int index) {
                    //                     return SizedBox(
                    //                       width: 55,
                    //                     );
                    //                   },
                    //                   //     children: [
                    //                   //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                    //                   //       SizedBox(height: 2,),
                    //                   //       Image.asset("assets/images/sun.png",scale: 1.6,),
                    //                   //     ],
                    //                   //   ),
                    //                   //   SizedBox(height: 30,),
                    //                   //   Sparkline(
                    //                   //
                    //                   //   //  gridLineAmount: 100,
                    //                   //     min: -50,
                    //                   //      max: 50,
                    //                   //
                    //                   //    pointIndex: 19,
                    //                   //     // gridLineWidth: 50,
                    //                   //     gridLineWidth:50,
                    //                   //       //sharpCorners: true,
                    //                   //       gridLineColor: Colors.white,
                    //                   //     //  kLine: ['max', 'min', 'first', 'last'],
                    //                   //      // fallbackWidth: 100,
                    //                   //
                    //                   //       lineColor: Colors.white,
                    //                   //       pointSize: 4,
                    //                   //       pointsMode: PointsMode.all,
                    //                   //       pointColor: Colors.white,
                    //                   //       //gridLineWidth: 10,
                    //                   //       //averageLabel: true,
                    //                   //     //  gridLineAmount: 5,
                    //                   //       data: data)
                    //                   //
                    //                   // ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ]),
                    //         ),
                    //       ]),
                    //   //   SizedBox(height: 15,),
                    //   //   Container(
                    //   //     child: Center(
                    //   //       child: RichText(
                    //   //          textAlign: TextAlign.center,
                    //   //         text:  TextSpan(
                    //   //
                    //   //             children:<TextSpan>[
                    //   //             TextSpan(text: "Today's Temperature\n",
                    //   //             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    //   //        TextSpan(text: "Expect the same as yesterday",
                    //   //             style: TextStyle(color: Colors.white.withOpacity(0.6),)),
                    //   //       ])
                    //   //       ),
                    //   //     ),
                    //   //     // width:,
                    //   //       height: 100,
                    //   //
                    //   //       decoration: BoxDecoration(
                    //   //         color: Colors.white.withOpacity(0.4),
                    //   //         borderRadius: BorderRadius.circular(20),
                    //   //         border: Border.all(
                    //   //           color: Colors.white.withOpacity(0.5),
                    //   //           width: 1.0,
                    //   //           style: BorderStyle.solid,
                    //   //         ),
                    //   //
                    //   //
                    //   //       )
                    //   //
                    //   //
                    //   //   ),
                    //   //
                    //   //
                    //   // ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //     child: Center(
                    //       child: RichText(
                    //           textAlign: TextAlign.center,
                    //           text: TextSpan(children: <TextSpan>[
                    //             TextSpan(
                    //                 text: "Today's Temperature\n",
                    //                 style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold)),
                    //             TextSpan(
                    //                 text: "Expect the same as yesterday",
                    //                 style: TextStyle(
                    //                   color: Colors.white.withOpacity(0.6),
                    //                 )),
                    //           ])),
                    //     ),
                    //     // width:,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white.withOpacity(0.4),
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         color: Colors.white.withOpacity(0.5),
                    //         width: 1.0,
                    //         style: BorderStyle.solid,
                    //       ),
                    //     )),
                  ]),
            ),
          ),
        ));
  }

  late Map loc;
  void asyncInitState() async {
    // final result = await getLoc();
    setState(() {
      //   loc = result;
    });
  }

  currentWeatherRepo? currentWeatherrepo;
  // String? cityname;

  Future<List<SearchedCity>> loadJson() async {
    String data = await rootBundle.loadString('assets/worldcities.json');
    List jsonResult = json.decode(data);

    print("jsondataaaaaaaa $jsonResult ");
    return jsonResult.map((e) => SearchedCity.fromjson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    //asyncInitState();
    super.initState();

    loadJson().then(
        (value) => BlocProvider.of<WeatherCubit>(context).allcitiess = value);
    //BlocProvider.of<WeatherCubit>(context).getcurrentweather();
    //print( BlocProvider.of<WeatherCubit>(context).cityname+"cityyyygyg");

    _scrollController = ScrollController()..addListener(_scrollListener);

    // getLoc().then((value) => loc=value);
    // print("locccccccccc${loc}");
    //  CurrentWeatherwebservice?  currentWeatherwebservice=  CurrentWeatherwebservice(loc["long"],loc["lat"]);
    //   currentWeatherrepo=  currentWeatherRepo(currentWeatherwebservice,loc["long"],loc["lat"]) ;

    // currentWeatherrepo.getcurrentweather().then((value) => currentlocation=value.name);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: isShrink?Colors.black:Color(0XFF87a5e1),
      body: BlocBuilder<WeatherCubit, weatherstates>(builder: (context, state) {
        if (BlocProvider.of<WeatherCubit>(context).cweather == null ||
            BlocProvider.of<WeatherCubit>(context).forecast == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is updatecity) {
          return SliderDrawer(
            key: _key,

            splashColor: Colors.black,
            appBar: Container(),
            child:  Container(

             color:  isShrink?Colors.black:Color(0XFF87a5e1),
              child: NestedScrollView(

                physics: NeverScrollableScrollPhysics(),
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    buildSliverAppbar(
                        state.cweather.weatherdetails[0].description,
                       state.cweather.name,
                        state
                            .cweather
                            .main
                            .temp
                            .toInt()
                            .toString(),
                        state
                            .cweather
                            .main
                            .temp_min
                            .toInt()
                            .toString(),
                        state
                            .cweather
                            .main
                            .temp_max
                            .toInt()
                            .toString(),
                        state
                            .cweather
                            .main
                            .feels_like
                            .toInt()
                            .toString(),
                        state.preception,
                        state.temptoday,
                        state.timestoday,
                        state.today)
                  ];
                },
                body: CustomScrollView(

                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            padding: EdgeInsets.only(left: 20,right: 15),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 200,
                                  //margin: EdgeInsets.only(left: 20,right: 15),
                                  // padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  //padding: EdgeInsets.only(left: 5,),
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          width: 400,
                                          child: Column(children: [
                                            Expanded(
                                              child: Container(
                                                //height: 100,
                                                padding: EdgeInsets.only(top: 13, left: 7),
                                                child: ListView.separated(
                                                  // shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount:  state.timestoday.length,
                                                  itemBuilder: (context, index) {
                                                    return Column(
                                                      children: [
                                                        Text(
                                                          state.timestoday[index],
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        if (state.today[index].dOrn == "d")
                                                          Image.asset(
                                                            "assets/images/sun.png",
                                                            width: 30,
                                                          )
                                                        else
                                                          Image.asset(
                                                            "assets/images/moon.png",
                                                            height: 30,
                                                            width: 25,
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context, int index) {
                                                    return const SizedBox(
                                                      width: 18,
                                                    );
                                                  },
                                                  //     children: [
                                                  //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                                  //       SizedBox(height: 2,),
                                                  //       Image.asset("assets/images/sun.png",scale: 1.6,),
                                                  //     ],
                                                  //   ),
                                                  //   SizedBox(height: 30,),
                                                  //   Sparkline(
                                                  //
                                                  //   //  gridLineAmount: 100,
                                                  //     min: -50,
                                                  //      max: 50,
                                                  //
                                                  //    pointIndex: 19,
                                                  //     // gridLineWidth: 50,
                                                  //     gridLineWidth:50,
                                                  //       //sharpCorners: true,
                                                  //       gridLineColor: Colors.white,
                                                  //     //  kLine: ['max', 'min', 'first', 'last'],
                                                  //      // fallbackWidth: 100,
                                                  //
                                                  //       lineColor: Colors.white,
                                                  //       pointSize: 4,
                                                  //       pointsMode: PointsMode.all,
                                                  //       pointColor: Colors.white,
                                                  //       //gridLineWidth: 10,
                                                  //       //averageLabel: true,
                                                  //     //  gridLineAmount: 5,
                                                  //       data: data)
                                                  //
                                                  // ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 23, right: 23, top: 15),
                                                child: Sparkline(

                                                  //  gridLineAmount: 100,
                                                    min: -50,
                                                    max: 50,
                                                    gridLineAmount: 5,
                                                    pointIndex: 1,
                                                    //gridLineWidth: 50,
                                                    // gridLineWidth:50,
                                                    //sharpCorners: true,
                                                    gridLineColor: Colors.white,
                                                    //  kLine: ['max', 'min', 'first', 'last'],
                                                    // fallbackWidth: 100,

                                                    lineColor: Colors.white,
                                                    pointSize: 4,
                                                    pointsMode: PointsMode.all,
                                                    pointColor: Colors.white,
                                                    //gridLineWidth: 10,
                                                    //averageLabel: true,
                                                    //  gridLineAmount: 5,
                                                    data: state.temptoday
                                                        .map((e) => e.toDouble())
                                                        .toList()),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                //height: 100,
                                                padding: EdgeInsets.only(top: 5,  left: 15),
                                                child: ListView.separated(
                                                  //shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),

                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: state.preception.length,
                                                  itemBuilder: (context, index) {
                                                    return Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/water.png",
                                                          scale: 0.9,
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          state.preception[index],
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 9,
                                                              fontWeight: FontWeight.bold),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context, int index) {
                                                    return SizedBox(
                                                      width: 11,
                                                    );
                                                  },
                                                  //     children: [
                                                  //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                                  //       SizedBox(height: 2,),
                                                  //       Image.asset("assets/images/sun.png",scale: 1.6,),
                                                  //     ],
                                                  //   ),
                                                  //   SizedBox(height: 30,),
                                                  //   Sparkline(
                                                  //
                                                  //   //  gridLineAmount: 100,
                                                  //     min: -50,
                                                  //      max: 50,
                                                  //
                                                  //    pointIndex: 19,
                                                  //     // gridLineWidth: 50,
                                                  //     gridLineWidth:50,
                                                  //       //sharpCorners: true,
                                                  //       gridLineColor: Colors.white,
                                                  //     //  kLine: ['max', 'min', 'first', 'last'],
                                                  //      // fallbackWidth: 100,
                                                  //
                                                  //       lineColor: Colors.white,
                                                  //       pointSize: 4,
                                                  //       pointsMode: PointsMode.all,
                                                  //       pointColor: Colors.white,
                                                  //       //gridLineWidth: 10,
                                                  //       //averageLabel: true,
                                                  //     //  gridLineAmount: 5,
                                                  //       data: data)
                                                  //
                                                  // ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ]),
                                  //   SizedBox(height: 15,),
                                  //   Container(
                                  //     child: Center(
                                  //       child: RichText(
                                  //          textAlign: TextAlign.center,
                                  //         text:  TextSpan(
                                  //
                                  //             children:<TextSpan>[
                                  //             TextSpan(text: "Today's Temperature\n",
                                  //             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                  //        TextSpan(text: "Expect the same as yesterday",
                                  //             style: TextStyle(color: Colors.white.withOpacity(0.6),)),
                                  //       ])
                                  //       ),
                                  //     ),
                                  //     // width:,
                                  //       height: 100,
                                  //
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white.withOpacity(0.4),
                                  //         borderRadius: BorderRadius.circular(20),
                                  //         border: Border.all(
                                  //           color: Colors.white.withOpacity(0.5),
                                  //           width: 1.0,
                                  //           style: BorderStyle.solid,
                                  //         ),
                                  //
                                  //
                                  //       )
                                  //
                                  //
                                  //   ),
                                  //
                                  //
                                  // ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Center(
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: "Today's Temperature\n",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold)),
                                            TextSpan(
                                                text: "Expect the same as yesterday",
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.6),
                                                )),
                                          ])),
                                    ),
                                    // width:,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //width:500,
                                        height: 285,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.5),
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        //margin: EdgeInsets.only(left: 20,right: 15),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,vertical: 10
                                        ),
                                        //padding: EdgeInsets.only(left: 5,),
                                        child:
                                        Center(
                                          child: buildDaysWeather(daystemp: state
                                              .daystemp,isshrink: isShrink,),
                                        )
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: 200,
                                          //margin: EdgeInsets.only(left: 20,right: 15),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 40.0,
                                          ),
                                          //padding: EdgeInsets.only(left: 5,),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text(
                                                      "Sunrise",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                        DateFormat.jm().format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                            state
                                                                .cweather
                                                                .sys
                                                                .sunrise *
                                                                1000)),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Image.asset("assets/images/sunrise.png")
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("Sunset",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15)),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                        DateFormat.jm().format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                            state
                                                                .cweather
                                                                .sys
                                                                .sunset *
                                                                1000)),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Image.asset("assets/images/sunset.png")
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.5),
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                  Container(
                                      width: double.infinity,
                                      height: 200,
                                      //margin: EdgeInsets.only(left: 20,right: 15),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0,
                                          horizontal: 20.0
                                      ),
                                      //padding: EdgeInsets.only(left: 5,),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Image.asset("assets/images/uv.png"),
                                                  SizedBox(width: 55,),
                                                  Image.asset("assets/images/wind.png"),
                                                  SizedBox(width: 55,),
                                                  Image.asset("assets/images/humidity.png"
                                                    ,height: 50,
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Text(
                                                  //   "Uv index\n High",
                                                  //   style: TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontWeight: FontWeight.w500,
                                                  //       fontSize: 15),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 2,
                                                  // ),
                                                  // Text("High",
                                                  //     style: TextStyle(
                                                  //         color: Colors.white,
                                                  //         fontWeight: FontWeight.w500,
                                                  //         fontSize: 15)),
                                                ],
                                              ),
                                            ),

                                            Expanded(
                                              child: Row(children: [
                                                Text(
                                                  "Uv index\nHigh",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(width: 40,),
                                                Center(
                                                  child: Text(
                                                    "Wind \n ${state
                                                        .cweather
                                                        .wind
                                                        .speed
                                                      .toStringAsFixed(1).toString()} "
                                                        "Km/h",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                SizedBox(width: 40,),
                                                Text(
                                                  "Humidity\n${ state
                                                      .cweather
                                                      .main
                                                      .humidity
                                                      .toString() +
                                                      "%"}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                              ],),
                                            ),
                                            // Divider(),
                                            // Column(
                                            //   children: [
                                            //     Image.asset("assets/images/wind.png"),
                                            //     SizedBox(
                                            //       height: 5,
                                            //     ),
                                            //     Text(
                                            //       "Wind",
                                            //       style: TextStyle(
                                            //           color: Colors.white,
                                            //           fontWeight: FontWeight.w500,
                                            //           fontSize: 15),
                                            //     ),
                                            //     SizedBox(
                                            //       height: 2,
                                            //     ),
                                            //     Text(
                                            //         BlocProvider.of<WeatherCubit>(context)
                                            //             .cweather!
                                            //             .wind
                                            //             .speed
                                            //             .toString() +
                                            //             " Km/h",
                                            //         style: const TextStyle(
                                            //             color: Colors.white,
                                            //             fontWeight: FontWeight.w500,
                                            //             fontSize: 15)),
                                            //   ],
                                            // ),
                                            // Divider(),
                                            // Column(
                                            //   children: [
                                            //     Image.asset("assets/images/humidity.png"
                                            //         ,width: 55,
                                            //         ),
                                            //     SizedBox(
                                            //       height: 5,
                                            //     ),
                                            //     const Text(
                                            //       "Humidity",
                                            //       style: TextStyle(
                                            //           color: Colors.white,
                                            //           fontWeight: FontWeight.w500,
                                            //           fontSize: 15),
                                            //     ),
                                            //     const SizedBox(
                                            //       height: 2,
                                            //     ),
                                            //     Text(
                                            //         BlocProvider.of<WeatherCubit>(context)
                                            //             .cweather!
                                            //             .main
                                            //             .humidity
                                            //        .toString() +
                                            //             "%",
                                            //         style: TextStyle(
                                            //             color: Colors.white,
                                            //             fontWeight: FontWeight.w500,
                                            //             fontSize: 15)),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 800,
                                      )
                                    ],
                                  ),
                                )

                              ],),
                          )

                        ]),
                      ),
                    ]),
              ),
            ),
            slider:Container(
               padding: EdgeInsets.all(15),
              //color: Colors.grey,
              decoration:    BoxDecoration(
                color: Color(0xff2e3842),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)
                ),


                border: Border.all(
                  color: Color(0xff2e3842),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),

              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 25,),color: Colors.white,),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star,color: Colors.white,size: 25),
                              const SizedBox(width: 20,),

                              Material(

                                color: Colors.transparent,
                                  child: InkWell(
                                      splashColor: Colors.white,
                                      child: Text("Favourite Location ",
                                        style: TextStyle(color: Colors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.bold),))),
                            ],
                          ),
                          // buildDrawerCities(BlocProvider.of<WeatherCubit>(context).managefavcities)
                        ],
                      ),

                      const Icon(Icons.info_outline,color: Colors.white,size: 25),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Material(
                        color: Colors.transparent,
                        child: InkWell(

                         splashColor:Colors.white ,
                          onTap: (){

                            BlocProvider.of<WeatherCubit>(context).getcurrentweather();
                          },
                          //
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.location_on,color: Colors.blueAccent,size: 17,),
                              const SizedBox(width: 2,),
                              Text(BlocProvider.of<WeatherCubit>(context).cweather!.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,

                            decoration:

                            BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),

                            ),

                          ),

                          const SizedBox(width: 8,),
                          Text("${ BlocProvider.of<WeatherCubit>(context).cweather?.main.temp.toInt()}°",style: TextStyle(color: Colors.white))
                        ],
                      ),

                    ],
                  ),

                  buildDrawerCities(BlocProvider.of<WeatherCubit>(context).managefavcities),
                 const SizedBox(height: 10,),
                  const Divider(color: Colors.white,),
                  // Icon()
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.add_location,color: Colors.white,size: 25),
                      const SizedBox(width: 20,),
                      Text("Other locations",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


                    ],

                  ),
                   //const SizedBox(height: 8,),
                  BlocProvider
                      .of<WeatherCubit>(context)
                      .managecities
                      .isNotEmpty?
                  SingleChildScrollView(

                    child: buildDrawerCities(BlocProvider.of<WeatherCubit>(context).managecities)
                  ):

                  Container(),

                  const SizedBox(height: 25,),
                  Center(
                    child: MaterialButton(
                      height: 45,
                      minWidth: double.infinity,
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(15),



                      ),

                      onPressed: (){},
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (v) {
                            return manageLocScreen(cweather:  BlocProvider.of<WeatherCubit>(context).cweather!,);
                          }));

                        },
                        child: Text("Manage locations",
                            style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold)),
                      ),),
                  ),
                  const Divider(color: Colors.white,),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      const Icon(Icons.info_outlined,color: Colors.white,size: 25),
                      const SizedBox(width: 20,),
                      Text("Report Wrong location",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


                    ],


                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      const Icon(Icons.headset_mic,color: Colors.white,size: 25),
                      const SizedBox(width: 20,),
                      Text("Contact Us",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


                    ],


                  ),
                ],



              ),
            ) ,


          );
          // return NestedScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   controller: _scrollController,
          //   headerSliverBuilder: (context, innerBoxIsScrolled) {
          //     return [
          //       buildSliverAppbar(
          //           state.searchedcityforecast.city.cityname,
          //           state.cweather.main.temp.toInt().toString(),
          //           state.cweather.main.temp_min.toInt().toString(),
          //           state.cweather.main.temp_max.toInt().toString(),
          //           state.cweather.main.feels_like.toInt().toString(),
          //           state.preception,
          //           state.temptoday,
          //           state.timestoday,
          //           state.today)
          //     ];
          //   },
          //   body: CustomScrollView(
          //
          //       slivers: [
          //         SliverList(
          //           delegate: SliverChildListDelegate([
          //             Container(
          //               padding: EdgeInsets.only(left: 20,right: 15),
          //               child: Column(
          //                 children: [
          //                   const SizedBox(
          //                     height: 20,
          //                   ),
          //                   Container(
          //                     decoration: BoxDecoration(
          //                       color: Colors.white.withOpacity(0.4),
          //                       borderRadius: BorderRadius.circular(20),
          //                       border: Border.all(
          //                         color: Colors.white.withOpacity(0.5),
          //                         width: 1.0,
          //                         style: BorderStyle.solid,
          //                       ),
          //                     ),
          //                     width: double.infinity,
          //                     height: 200,
          //                     //margin: EdgeInsets.only(left: 20,right: 15),
          //                     // padding: EdgeInsets.symmetric(horizontal: 10.0),
          //                     //padding: EdgeInsets.only(left: 5,),
          //                     child: ListView(
          //                         scrollDirection: Axis.horizontal,
          //                         shrinkWrap: true,
          //                         children: [
          //                           Container(
          //                             width: 400,
          //                             child: Column(children: [
          //                               Expanded(
          //                                 child: Container(
          //                                   //height: 100,
          //                                   padding: EdgeInsets.only(top: 13, left: 15),
          //                                   child: ListView.separated(
          //                                     // shrinkWrap: true,
          //                                     scrollDirection: Axis.horizontal,
          //                                     itemCount:  state.timestoday.length,
          //                                     itemBuilder: (context, index) {
          //                                       return Column(
          //                                         children: [
          //                                           Text(
          //                                             state.timestoday[index],
          //                                             style: const TextStyle(
          //                                                 color: Colors.white,
          //                                                 fontSize: 11,
          //                                                 fontWeight: FontWeight.bold),
          //                                           ),
          //                                           const SizedBox(
          //                                             height: 2,
          //                                           ),
          //                                           if ( state.today[index].dOrn == "d")
          //                                             Image.asset(
          //                                               "assets/images/sun.png",
          //                                               width: 30,
          //                                             )
          //                                           else
          //                                             Image.asset(
          //                                               "assets/images/moon.png",
          //                                               height: 30,
          //                                               width: 25,
          //                                             ),
          //                                         ],
          //                                       );
          //                                     },
          //                                     separatorBuilder:
          //                                         (BuildContext context, int index) {
          //                                       return const SizedBox(
          //                                         width: 27,
          //                                       );
          //                                     },
          //                                     //     children: [
          //                                     //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
          //                                     //       SizedBox(height: 2,),
          //                                     //       Image.asset("assets/images/sun.png",scale: 1.6,),
          //                                     //     ],
          //                                     //   ),
          //                                     //   SizedBox(height: 30,),
          //                                     //   Sparkline(
          //                                     //
          //                                     //   //  gridLineAmount: 100,
          //                                     //     min: -50,
          //                                     //      max: 50,
          //                                     //
          //                                     //    pointIndex: 19,
          //                                     //     // gridLineWidth: 50,
          //                                     //     gridLineWidth:50,
          //                                     //       //sharpCorners: true,
          //                                     //       gridLineColor: Colors.white,
          //                                     //     //  kLine: ['max', 'min', 'first', 'last'],
          //                                     //      // fallbackWidth: 100,
          //                                     //
          //                                     //       lineColor: Colors.white,
          //                                     //       pointSize: 4,
          //                                     //       pointsMode: PointsMode.all,
          //                                     //       pointColor: Colors.white,
          //                                     //       //gridLineWidth: 10,
          //                                     //       //averageLabel: true,
          //                                     //     //  gridLineAmount: 5,
          //                                     //       data: data)
          //                                     //
          //                                     // ],
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 height: 20,
          //                               ),
          //                               Expanded(
          //                                 child: Padding(
          //                                   padding: EdgeInsets.only(
          //                                       left: 30, right: 15, top: 15),
          //                                   child: Sparkline(
          //
          //                                     //  gridLineAmount: 100,
          //                                       min: -50,
          //                                       max: 50,
          //                                       gridLineAmount: 5,
          //                                       pointIndex: 1,
          //                                       //gridLineWidth: 50,
          //                                       // gridLineWidth:50,
          //                                       //sharpCorners: true,
          //                                       gridLineColor: Colors.white,
          //                                       //  kLine: ['max', 'min', 'first', 'last'],
          //                                       // fallbackWidth: 100,
          //
          //                                       lineColor: Colors.white,
          //                                       pointSize: 4,
          //                                       pointsMode: PointsMode.all,
          //                                       pointColor: Colors.white,
          //                                       //gridLineWidth: 10,
          //                                       //averageLabel: true,
          //                                       //  gridLineAmount: 5,
          //                                       data: state.temptoday
          //                                           .map((e) => e.toDouble())
          //                                           .toList()),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 child: Container(
          //                                   //height: 100,
          //                                   padding: EdgeInsets.only(top: 5, left: 23),
          //                                   child: ListView.separated(
          //                                     //shrinkWrap: true,
          //                                     physics: NeverScrollableScrollPhysics(),
          //
          //                                     scrollDirection: Axis.horizontal,
          //                                     itemCount: state.preception.length,
          //                                     itemBuilder: (context, index) {
          //                                       return Row(
          //                                         children: [
          //                                           Image.asset(
          //                                             "assets/images/water.png",
          //                                             scale: 0.9,
          //                                             width: 17,
          //                                           ),
          //                                           Text(
          //                                            state.preception[index],
          //                                             style: TextStyle(
          //                                                 color: Colors.white,
          //                                                 fontSize: 11,
          //                                                 fontWeight: FontWeight.bold),
          //                                           )
          //                                         ],
          //                                       );
          //                                     },
          //                                     separatorBuilder:
          //                                         (BuildContext context, int index) {
          //                                       return SizedBox(
          //                                         width: 14,
          //                                       );
          //                                     },
          //                                     //     children: [
          //                                     //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
          //                                     //       SizedBox(height: 2,),
          //                                     //       Image.asset("assets/images/sun.png",scale: 1.6,),
          //                                     //     ],
          //                                     //   ),
          //                                     //   SizedBox(height: 30,),
          //                                     //   Sparkline(
          //                                     //
          //                                     //   //  gridLineAmount: 100,
          //                                     //     min: -50,
          //                                     //      max: 50,
          //                                     //
          //                                     //    pointIndex: 19,
          //                                     //     // gridLineWidth: 50,
          //                                     //     gridLineWidth:50,
          //                                     //       //sharpCorners: true,
          //                                     //       gridLineColor: Colors.white,
          //                                     //     //  kLine: ['max', 'min', 'first', 'last'],
          //                                     //      // fallbackWidth: 100,
          //                                     //
          //                                     //       lineColor: Colors.white,
          //                                     //       pointSize: 4,
          //                                     //       pointsMode: PointsMode.all,
          //                                     //       pointColor: Colors.white,
          //                                     //       //gridLineWidth: 10,
          //                                     //       //averageLabel: true,
          //                                     //     //  gridLineAmount: 5,
          //                                     //       data: data)
          //                                     //
          //                                     // ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ]),
          //                           ),
          //                         ]),
          //                     //   SizedBox(height: 15,),
          //                     //   Container(
          //                     //     child: Center(
          //                     //       child: RichText(
          //                     //          textAlign: TextAlign.center,
          //                     //         text:  TextSpan(
          //                     //
          //                     //             children:<TextSpan>[
          //                     //             TextSpan(text: "Today's Temperature\n",
          //                     //             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          //                     //        TextSpan(text: "Expect the same as yesterday",
          //                     //             style: TextStyle(color: Colors.white.withOpacity(0.6),)),
          //                     //       ])
          //                     //       ),
          //                     //     ),
          //                     //     // width:,
          //                     //       height: 100,
          //                     //
          //                     //       decoration: BoxDecoration(
          //                     //         color: Colors.white.withOpacity(0.4),
          //                     //         borderRadius: BorderRadius.circular(20),
          //                     //         border: Border.all(
          //                     //           color: Colors.white.withOpacity(0.5),
          //                     //           width: 1.0,
          //                     //           style: BorderStyle.solid,
          //                     //         ),
          //                     //
          //                     //
          //                     //       )
          //                     //
          //                     //
          //                     //   ),
          //                     //
          //                     //
          //                     // ],
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   Container(
          //                       child: Center(
          //                         child: RichText(
          //                             textAlign: TextAlign.center,
          //                             text: TextSpan(children: <TextSpan>[
          //                               TextSpan(
          //                                   text: "Today's Temperature\n",
          //                                   style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.bold)),
          //                               TextSpan(
          //                                   text: "Expect the same as yesterday",
          //                                   style: TextStyle(
          //                                     color: Colors.white.withOpacity(0.6),
          //                                   )),
          //                             ])),
          //                       ),
          //                       // width:,
          //                       height: 100,
          //                       decoration: BoxDecoration(
          //                         color: Colors.white.withOpacity(0.4),
          //                         borderRadius: BorderRadius.circular(20),
          //                         border: Border.all(
          //                           color: Colors.white.withOpacity(0.5),
          //                           width: 1.0,
          //                           style: BorderStyle.solid,
          //                         ),
          //                       )),
          //                   const SizedBox(
          //                     height: 15,
          //                   ),
          //                   Container(
          //
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           //width:500,
          //                           height: 400,
          //                           decoration: BoxDecoration(
          //                             color: Colors.white.withOpacity(0.4),
          //                             borderRadius: BorderRadius.circular(20),
          //                             border: Border.all(
          //                               color: Colors.white.withOpacity(0.5),
          //                               width: 1.0,
          //                               style: BorderStyle.solid,
          //                             ),
          //                           ),
          //                           //margin: EdgeInsets.only(left: 20,right: 15),
          //                           padding: const EdgeInsets.symmetric(
          //                             horizontal: 10.0,
          //                           ),
          //                           //padding: EdgeInsets.only(left: 5,),
          //                           child: Row(
          //                             children: [
          //                               Expanded(
          //                                 child: ListView.separated(
          //                                   // scrollDirection: Axis.vertical,
          //                                     shrinkWrap: true,
          //                                     // physics: NeverScrollableScrollPhysics(),
          //                                     itemBuilder: (context, index) {
          //                                       return Text(
          //                                       " ${ state
          //                                             .daystemp[index]["day"]}",
          //                                         style: const TextStyle(
          //                                           color: Colors.grey,
          //                                           fontWeight: FontWeight.w500,
          //                                         ),
          //                                       );
          //                                     },
          //                                     separatorBuilder: (context, index) {
          //                                       return SizedBox(height: 30);
          //                                     },
          //                                     itemCount:
          //                                    state
          //                                         .daystemp
          //                                         .length),
          //                               ),
          //                               Expanded(
          //                                 child: ListView.separated(
          //                                   //scrollDirection: Axis.vertical,
          //                                     shrinkWrap: true,
          //                                     // physics: NeverScrollableScrollPhysics(),
          //
          //                                     itemBuilder: (context, index) {
          //                                       return Row(
          //                                         children: [
          //                                           Row(
          //                                             children: [
          //                                               Image.asset(
          //                                                 "assets/images/water.png",
          //                                                 scale: 0.9,
          //                                                 width: 17,
          //                                               ),
          //                                               humdity[index],
          //                                             ],
          //                                           ),
          //                                           SizedBox(
          //                                             width: 3,
          //                                           ),
          //                                           Image.asset(
          //                                             "assets/images/sun.png",
          //                                             scale: 0.9,
          //                                             width: 30,
          //                                           ),
          //                                           SizedBox(
          //                                             width: 3,
          //                                           ),
          //                                           Image.asset(
          //                                             "assets/images/moon.png",
          //                                             scale: 0.9,
          //                                             width: 30,
          //                                           ),
          //                                           SizedBox(
          //                                             width: 3,
          //                                           ),
          //                                           Text(
          //                                       "${state
          //                                                 .daystemp[index]["maxtemp"]
          //                                                 .toString()}",
          //                                             style: TextStyle(
          //                                               color: Colors.grey,
          //                                               fontWeight: FontWeight.w500,
          //                                             ),
          //                                           ),
          //                                           SizedBox(
          //                                             width: 3,
          //                                           ),
          //                                           Text(
          //                                            state
          //                                                 .daystemp[index]["mintemp"]
          //                                                 .toString(),
          //                                             style: TextStyle(
          //                                               color: Colors.grey,
          //                                               fontWeight: FontWeight.w500,
          //                                             ),
          //                                           )
          //                                         ],
          //                                       );
          //                                     },
          //                                     separatorBuilder: (context, index) {
          //                                       return SizedBox(height: 17);
          //                                     },
          //                                     itemCount:
          //                                   state
          //                                         .daystemp
          //                                         .length),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           height: 15,
          //                         ),
          //                         Container(
          //                             width: double.infinity,
          //                             height: 200,
          //                             //margin: EdgeInsets.only(left: 20,right: 15),
          //                             padding: EdgeInsets.symmetric(
          //                               vertical: 40.0,
          //                             ),
          //                             //padding: EdgeInsets.only(left: 5,),
          //                             child: Center(
          //                               child: Row(
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.spaceAround,
          //                                 children: [
          //                                   Column(
          //                                     children: [
          //                                       const Text(
          //                                         "Sunrise",
          //                                         style: TextStyle(
          //                                             color: Colors.white,
          //                                             fontWeight: FontWeight.w500,
          //                                             fontSize: 15),
          //                                       ),
          //                                       SizedBox(
          //                                         height: 2,
          //                                       ),
          //                                       Text(
          //                                           DateFormat.jm().format(DateTime
          //                                               .fromMillisecondsSinceEpoch(
          //                                               state
          //                                                   .cweather
          //                                                   .sys
          //                                                   .sunrise *
          //                                                   1000)),
          //                                           style: const TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Image.asset("assets/images/sunrise.png")
          //                                     ],
          //                                   ),
          //                                   Column(
          //                                     children: [
          //                                       Text("Sunset",
          //                                           style: TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                       SizedBox(
          //                                         height: 2,
          //                                       ),
          //                                       Text(
          //                                           DateFormat.jm().format(DateTime
          //                                               .fromMillisecondsSinceEpoch(
          //                                               state
          //                                                   .cweather
          //                                                   .sys
          //                                                   .sunset *
          //                                                   1000)),
          //                                           style: const TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Image.asset("assets/images/sunset.png")
          //                                     ],
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                             decoration: BoxDecoration(
          //                               color: Colors.white.withOpacity(0.4),
          //                               borderRadius: BorderRadius.circular(20),
          //                               border: Border.all(
          //                                 color: Colors.white.withOpacity(0.5),
          //                                 width: 1.0,
          //                                 style: BorderStyle.solid,
          //                               ),
          //                             )),
          //                         const SizedBox(
          //                           height: 15,
          //                         ),
          //                         Container(
          //                             width: double.infinity,
          //                             height: 200,
          //                             //margin: EdgeInsets.only(left: 20,right: 15),
          //                             padding: const EdgeInsets.symmetric(
          //                               vertical: 40.0,
          //                             ),
          //                             //padding: EdgeInsets.only(left: 5,),
          //                             child: Center(
          //                               child: Row(
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.spaceAround,
          //                                 children: [
          //                                   Column(
          //                                     children: [
          //                                       Image.asset("assets/images/uv.png"),
          //                                       SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Text(
          //                                         "Uv index",
          //                                         style: TextStyle(
          //                                             color: Colors.white,
          //                                             fontWeight: FontWeight.w500,
          //                                             fontSize: 15),
          //                                       ),
          //                                       SizedBox(
          //                                         height: 2,
          //                                       ),
          //                                       Text("High",
          //                                           style: TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                     ],
          //                                   ),
          //                                   Divider(),
          //                                   Column(
          //                                     children: [
          //                                       Image.asset("assets/images/wind.png"),
          //                                       SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Text(
          //                                         "Wind",
          //                                         style: TextStyle(
          //                                             color: Colors.white,
          //                                             fontWeight: FontWeight.w500,
          //                                             fontSize: 15),
          //                                       ),
          //                                       SizedBox(
          //                                         height: 2,
          //                                       ),
          //                                       Text(
          //                                           state
          //                                               .cweather
          //                                               .wind
          //                                               .speed
          //                                               .toString() +
          //                                               " Km/h",
          //                                           style: const TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                     ],
          //                                   ),
          //                                   Divider(),
          //                                   Column(
          //                                     children: [
          //                                       Image.asset("assets/images/humidity.png"),
          //                                       SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Text(
          //                                         "Humidity",
          //                                         style: TextStyle(
          //                                             color: Colors.white,
          //                                             fontWeight: FontWeight.w500,
          //                                             fontSize: 15),
          //                                       ),
          //                                       SizedBox(
          //                                         height: 2,
          //                                       ),
          //                                       Text(
          //                                         state
          //                                               .cweather
          //                                               .main
          //                                               .humidity
          //                                               .toString() +
          //                                               "%",
          //                                           style: TextStyle(
          //                                               color: Colors.white,
          //                                               fontWeight: FontWeight.w500,
          //                                               fontSize: 15)),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             decoration: BoxDecoration(
          //                               color: Colors.white.withOpacity(0.4),
          //                               borderRadius: BorderRadius.circular(20),
          //                               border: Border.all(
          //                                 color: Colors.white.withOpacity(0.5),
          //                                 width: 1.0,
          //                                 style: BorderStyle.solid,
          //                               ),
          //                             )),
          //                         SizedBox(
          //                           height: 800,
          //                         )
          //                       ],
          //                     ),
          //                   )
          //
          //                 ],),
          //             )
          //
          //           ]),
          //         ),
          //       ]),
          // );
        }
        else {
          return SliderDrawer(
            key: _key,

            splashColor: Colors.black,
            appBar: Container(),
              child:  Container(
                color:  isShrink?Colors.black:Color(0XFF87a5e1),
                child: NestedScrollView(

            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  buildSliverAppbar(
                      BlocProvider.of<WeatherCubit>(context).cweather!.weatherdetails[0].description,
                      BlocProvider.of<WeatherCubit>(context).cweather!.name,
                      BlocProvider.of<WeatherCubit>(context)
                          .cweather!
                          .main
                          .temp
                          .toInt()
                          .toString(),
                      BlocProvider.of<WeatherCubit>(context)
                          .cweather!
                          .main
                          .temp_min
                          .toInt()
                          .toString(),
                      BlocProvider.of<WeatherCubit>(context)
                          .cweather!
                          .main
                          .temp_max
                          .toInt()
                          .toString(),
                      BlocProvider.of<WeatherCubit>(context)
                          .cweather!
                          .main
                          .feels_like
                          .toInt()
                          .toString(),
                      BlocProvider.of<WeatherCubit>(context).preception,
                      BlocProvider.of<WeatherCubit>(context).temptoday,
                      BlocProvider.of<WeatherCubit>(context).timestoday,
                      BlocProvider.of<WeatherCubit>(context).today)
                ];
            },
            body: CustomScrollView(

                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 15),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                width: double.infinity,
                                height: 200,
                                //margin: EdgeInsets.only(left: 20,right: 15),
                                // padding: EdgeInsets.symmetric(horizontal: 10.0),
                                //padding: EdgeInsets.only(left: 5,),
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        width: 400,
                                        child: Column(children: [
                                          Expanded(
                                            child: Container(
                                              //height: 100,
                                              padding: EdgeInsets.only(top: 13, left: 7),
                                              child: ListView.separated(
                                                // shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount:   BlocProvider.of<WeatherCubit>(context).timestoday.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        BlocProvider.of<WeatherCubit>(context).timestoday[index],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      if ( BlocProvider.of<WeatherCubit>(context).today[index].dOrn == "d")
                                                        Image.asset(
                                                          "assets/images/sun.png",
                                                          width: 30,
                                                        )
                                                      else
                                                        Image.asset(
                                                          "assets/images/moon.png",
                                                          height: 30,
                                                          width: 25,
                                                        ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context, int index) {
                                                  return const SizedBox(
                                                    width: 18,
                                                  );
                                                },
                                                //     children: [
                                                //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                                //       SizedBox(height: 2,),
                                                //       Image.asset("assets/images/sun.png",scale: 1.6,),
                                                //     ],
                                                //   ),
                                                //   SizedBox(height: 30,),
                                                //   Sparkline(
                                                //
                                                //   //  gridLineAmount: 100,
                                                //     min: -50,
                                                //      max: 50,
                                                //
                                                //    pointIndex: 19,
                                                //     // gridLineWidth: 50,
                                                //     gridLineWidth:50,
                                                //       //sharpCorners: true,
                                                //       gridLineColor: Colors.white,
                                                //     //  kLine: ['max', 'min', 'first', 'last'],
                                                //      // fallbackWidth: 100,
                                                //
                                                //       lineColor: Colors.white,
                                                //       pointSize: 4,
                                                //       pointsMode: PointsMode.all,
                                                //       pointColor: Colors.white,
                                                //       //gridLineWidth: 10,
                                                //       //averageLabel: true,
                                                //     //  gridLineAmount: 5,
                                                //       data: data)
                                                //
                                                // ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 23, right: 23, top: 15),
                                              child: Sparkline(

                                                //  gridLineAmount: 100,
                                                  min: -50,
                                                  max: 50,
                                                  gridLineAmount: 5,
                                                  pointIndex: 1,
                                                  //gridLineWidth: 50,
                                                  // gridLineWidth:50,
                                                  //sharpCorners: true,
                                                  gridLineColor: Colors.white,
                                                  //  kLine: ['max', 'min', 'first', 'last'],
                                                  // fallbackWidth: 100,

                                                  lineColor: Colors.white,
                                                  pointSize: 4,
                                                  pointsMode: PointsMode.all,
                                                  pointColor: Colors.white,
                                                  //gridLineWidth: 10,
                                                  //averageLabel: true,
                                                  //  gridLineAmount: 5,
                                                  data:  BlocProvider.of<WeatherCubit>(context).temptoday
                                                      .map((e) => e.toDouble())
                                                      .toList()),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              //height: 100,
                                              padding: EdgeInsets.only(top: 5,  left: 15),
                                              child: ListView.separated(
                                                //shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),

                                                scrollDirection: Axis.horizontal,
                                                itemCount:  BlocProvider.of<WeatherCubit>(context).preception.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/water.png",
                                                        scale: 0.9,
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        BlocProvider.of<WeatherCubit>(context).preception[index],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 9,
                                                            fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context, int index) {
                                                  return SizedBox(
                                                    width: 11,
                                                  );
                                                },
                                                //     children: [
                                                //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                                //       SizedBox(height: 2,),
                                                //       Image.asset("assets/images/sun.png",scale: 1.6,),
                                                //     ],
                                                //   ),
                                                //   SizedBox(height: 30,),
                                                //   Sparkline(
                                                //
                                                //   //  gridLineAmount: 100,
                                                //     min: -50,
                                                //      max: 50,
                                                //
                                                //    pointIndex: 19,
                                                //     // gridLineWidth: 50,
                                                //     gridLineWidth:50,
                                                //       //sharpCorners: true,
                                                //       gridLineColor: Colors.white,
                                                //     //  kLine: ['max', 'min', 'first', 'last'],
                                                //      // fallbackWidth: 100,
                                                //
                                                //       lineColor: Colors.white,
                                                //       pointSize: 4,
                                                //       pointsMode: PointsMode.all,
                                                //       pointColor: Colors.white,
                                                //       //gridLineWidth: 10,
                                                //       //averageLabel: true,
                                                //     //  gridLineAmount: 5,
                                                //       data: data)
                                                //
                                                // ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ]),
                                //   SizedBox(height: 15,),
                                //   Container(
                                //     child: Center(
                                //       child: RichText(
                                //          textAlign: TextAlign.center,
                                //         text:  TextSpan(
                                //
                                //             children:<TextSpan>[
                                //             TextSpan(text: "Today's Temperature\n",
                                //             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                //        TextSpan(text: "Expect the same as yesterday",
                                //             style: TextStyle(color: Colors.white.withOpacity(0.6),)),
                                //       ])
                                //       ),
                                //     ),
                                //     // width:,
                                //       height: 100,
                                //
                                //       decoration: BoxDecoration(
                                //         color: Colors.white.withOpacity(0.4),
                                //         borderRadius: BorderRadius.circular(20),
                                //         border: Border.all(
                                //           color: Colors.white.withOpacity(0.5),
                                //           width: 1.0,
                                //           style: BorderStyle.solid,
                                //         ),
                                //
                                //
                                //       )
                                //
                                //
                                //   ),
                                //
                                //
                                // ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  child: Center(
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "Today's Temperature\n",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: "Expect the same as yesterday",
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.6),
                                              )),
                                        ])),
                                  ),
                                  // width:,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      //width:500,
                                      height: 285,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      //margin: EdgeInsets.only(left: 20,right: 15),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,

                                      ),
                                      //padding: EdgeInsets.only(left: 5,),
                                      child: buildDaysWeather(daystemp: BlocProvider.of<WeatherCubit>(context)
                                          .daystemp,isshrink: isShrink,)
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 200,
                                        //margin: EdgeInsets.only(left: 20,right: 15),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 40.0,
                                        ),
                                        //padding: EdgeInsets.only(left: 5,),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Sunrise",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      DateFormat.jm().format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          BlocProvider.of<WeatherCubit>(
                                                              context)
                                                              .cweather!
                                                              .sys
                                                              .sunrise *
                                                              1000)),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15)),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset("assets/images/sunrise.png")
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("Sunset",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15)),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                      DateFormat.jm().format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                          BlocProvider.of<WeatherCubit>(
                                                              context)
                                                              .cweather!
                                                              .sys
                                                              .sunset *
                                                              1000)),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset("assets/images/sunset.png")
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.5),
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 200,
                                        //margin: EdgeInsets.only(left: 20,right: 15),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 40.0,
                                          horizontal: 20.0
                                        ),
                                        //padding: EdgeInsets.only(left: 5,),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Image.asset("assets/images/uv.png"),
                                                    SizedBox(width: 55,),
                                                    Image.asset("assets/images/wind.png"),
                                                    SizedBox(width: 55,),
                                                    Image.asset("assets/images/humidity.png"
                                                    ,height: 50,
                                                    ),
                                                    // SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    // Text(
                                                    //   "Uv index\n High",
                                                    //   style: TextStyle(
                                                    //       color: Colors.white,
                                                    //       fontWeight: FontWeight.w500,
                                                    //       fontSize: 15),
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 2,
                                                    // ),
                                                    // Text("High",
                                                    //     style: TextStyle(
                                                    //         color: Colors.white,
                                                    //         fontWeight: FontWeight.w500,
                                                    //         fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                              
                                              Expanded(
                                                child: Row(children: [
                                                  Text(
                                                    "Uv index\nHigh",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(width: 40,),
                                                  Center(
                                                    child: Text(
                                                      "Wind \n ${BlocProvider.of<WeatherCubit>(context)
                                                          .cweather!
                                                          .wind
                                                          .speed
                                                          .toStringAsFixed(1).toString()} "
                                                          "Km/h",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(width: 40,),
                                                   Text(
                                                    "Humidity\n${           BlocProvider.of<WeatherCubit>(context)
                                                        .cweather!
                                                        .main
                                                        .humidity
                                                        .toString() +
                                                        "%"}",
                                                     textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                ],),
                                              ),
                                              // Divider(),
                                              // Column(
                                              //   children: [
                                              //     Image.asset("assets/images/wind.png"),
                                              //     SizedBox(
                                              //       height: 5,
                                              //     ),
                                              //     Text(
                                              //       "Wind",
                                              //       style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontWeight: FontWeight.w500,
                                              //           fontSize: 15),
                                              //     ),
                                              //     SizedBox(
                                              //       height: 2,
                                              //     ),
                                              //     Text(
                                              //         BlocProvider.of<WeatherCubit>(context)
                                              //             .cweather!
                                              //             .wind
                                              //             .speed
                                              //             .toString() +
                                              //             " Km/h",
                                              //         style: const TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.w500,
                                              //             fontSize: 15)),
                                              //   ],
                                              // ),
                                              // Divider(),
                                              // Column(
                                              //   children: [
                                              //     Image.asset("assets/images/humidity.png"
                                              //         ,width: 55,
                                              //         ),
                                              //     SizedBox(
                                              //       height: 5,
                                              //     ),
                                              //     const Text(
                                              //       "Humidity",
                                              //       style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontWeight: FontWeight.w500,
                                              //           fontSize: 15),
                                              //     ),
                                              //     const SizedBox(
                                              //       height: 2,
                                              //     ),
                                              //     Text(
                                              //         BlocProvider.of<WeatherCubit>(context)
                                              //             .cweather!
                                              //             .main
                                              //             .humidity
                                              //        .toString() +
                                              //             "%",
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.w500,
                                              //             fontSize: 15)),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.5),
                                            width: 1.0,
                                            style: BorderStyle.solid,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 800,
                                    )
                                  ],
                                ),
                              )

                            ],),
                        )

                      ]),
                    ),
                  ]),
          ),
              ),
          slider:Container(

            //color: Colors.grey,
            padding: EdgeInsets.all(15),
            //color: Colors.grey,
            decoration:    BoxDecoration(
              color: Color(0xff2e3842),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)
              ),


              border: Border.all(
                color: Color(0xff2e3842),
                width: 1.0,
                style: BorderStyle.solid,
              ),

            ),
            child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 25,),color: Colors.white,),
            SizedBox(height: 30,),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
            children: [
            Icon(Icons.star,color: Colors.white,size: 25),
            SizedBox(width: 20,),
            Text("Favourite Location ",
              style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold),),
            ],
            ),

            Icon(Icons.info_outline,color: Colors.white,size: 25),
            ],
            ),
            SizedBox(height: 25,),
            Column(
              children: [

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      BlocProvider.of<WeatherCubit>(context).getcurrentweather();
                    },
                    splashColor: Colors.white,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Row(
                    children: [
                    Icon(Icons.location_on,color: Colors.blueAccent,size: 17,),
                    SizedBox(width: 2,),
                    Text( BlocProvider.of<WeatherCubit>(context).cweather!.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                    ),

                    Row(
                    children: [
                    Container(
                    width: 15,
                    height: 15,

                    decoration:

                    BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.0,
                    style: BorderStyle.solid,
                    ),

                    ),

                    ),

                    SizedBox(width: 8,),
                    Text("${ BlocProvider.of<WeatherCubit>(context).cweather!.main.temp.toInt()}°",style: TextStyle(color: Colors.white))
                    ],
                    ),

                    ],
                    ),
                  ),
                ),
                buildDrawerCities(BlocProvider.of<WeatherCubit>(context).managefavcities)
              ],
            ),
              SizedBox(height: 10,),
            Divider(color: Colors.white,),

            // Icon()
            Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Icon(Icons.add_location,color: Colors.white,size: 25),
            SizedBox(width: 20,),
            Text("Other locations",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


            ],

            ),
            // const SizedBox(height: 25,),
             BlocProvider
                  .of<WeatherCubit>(context)
                  .managecities
                  .isNotEmpty?
              SingleChildScrollView(
               // height: 200,
                child: buildDrawerCities(BlocProvider.of<WeatherCubit>(context).managecities)
              ):

             Container(),

            const SizedBox(height: 25,),
            Center(
            child: MaterialButton(
            height: 45,
            minWidth: double.infinity,
            color: Colors.grey,
            shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(15),



            ),

            onPressed: (){},
            child: MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (v) {
                  return manageLocScreen(cweather:  BlocProvider.of<WeatherCubit>(context).cweather!,);
                }));

              },
              child: Text("Manage locations",
              style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold)),
            ),),
            ),
            const Divider(color: Colors.white,),
            const SizedBox(height: 25,),
            Row(
            children: [
            const Icon(Icons.info_outlined,color: Colors.white,size: 25),
            const SizedBox(width: 20,),
            Text("Report Wrong location",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


            ],


            ),
            SizedBox(height: 20,),
            Row(
            children: [
            const Icon(Icons.headset_mic,color: Colors.white,size: 25),
            const SizedBox(width: 20,),
            Text("Contact Us",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


            ],


            ),
            ],



            ),
          ) ,


                  );
          // return NestedScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   controller: _scrollController,
          //   headerSliverBuilder: (context, innerBoxIsScrolled) {
          //     return [
          //       buildSliverAppbar(
          //           BlocProvider.of<WeatherCubit>(context).cweather!.name,
          //           BlocProvider.of<WeatherCubit>(context)
          //               .cweather!
          //               .main
          //               .temp
          //               .toInt()
          //               .toString(),
          //           BlocProvider.of<WeatherCubit>(context)
          //               .cweather!
          //               .main
          //               .temp_min
          //               .toInt()
          //               .toString(),
          //           BlocProvider.of<WeatherCubit>(context)
          //               .cweather!
          //               .main
          //               .temp_max
          //               .toInt()
          //               .toString(),
          //           BlocProvider.of<WeatherCubit>(context)
          //               .cweather!
          //               .main
          //               .feels_like
          //               .toInt()
          //               .toString(),
          //           BlocProvider.of<WeatherCubit>(context).preception,
          //           BlocProvider.of<WeatherCubit>(context).temptoday,
          //           BlocProvider.of<WeatherCubit>(context).timestoday,
          //           BlocProvider.of<WeatherCubit>(context).today)
          //     ];
          //   },
          //   body: CustomScrollView(
          //
          //       slivers: [
          //     SliverList(
          //       delegate: SliverChildListDelegate([
          //         Container(
          //           padding: EdgeInsets.only(left: 20,right: 15),
          //           child: Column(
          //             children: [
          //             const SizedBox(
          //               height: 20,
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 color: Colors.white.withOpacity(0.4),
          //                 borderRadius: BorderRadius.circular(20),
          //                 border: Border.all(
          //                   color: Colors.white.withOpacity(0.5),
          //                   width: 1.0,
          //                   style: BorderStyle.solid,
          //                 ),
          //               ),
          //               width: double.infinity,
          //               height: 200,
          //               //margin: EdgeInsets.only(left: 20,right: 15),
          //               // padding: EdgeInsets.symmetric(horizontal: 10.0),
          //               //padding: EdgeInsets.only(left: 5,),
          //               child: ListView(
          //                   scrollDirection: Axis.horizontal,
          //                   shrinkWrap: true,
          //                   children: [
          //                     Container(
          //                       width: 400,
          //                       child: Column(children: [
          //                         Expanded(
          //                           child: Container(
          //                             //height: 100,
          //                             padding: EdgeInsets.only(top: 13, left: 15),
          //                             child: ListView.separated(
          //                               // shrinkWrap: true,
          //                               scrollDirection: Axis.horizontal,
          //                               itemCount:  BlocProvider.of<WeatherCubit>(context).timestoday.length,
          //                               itemBuilder: (context, index) {
          //                                 return Column(
          //                                   children: [
          //                                     Text(
          //                                       BlocProvider.of<WeatherCubit>(context).timestoday[index],
          //                                       style: const TextStyle(
          //                                           color: Colors.white,
          //                                           fontSize: 11,
          //                                           fontWeight: FontWeight.bold),
          //                                     ),
          //                                     const SizedBox(
          //                                       height: 2,
          //                                     ),
          //                                     if ( BlocProvider.of<WeatherCubit>(context).today[index].dOrn == "d")
          //                                       Image.asset(
          //                                         "assets/images/sun.png",
          //                                         width: 30,
          //                                       )
          //                                     else
          //                                       Image.asset(
          //                                         "assets/images/moon.png",
          //                                         height: 30,
          //                                         width: 25,
          //                                       ),
          //                                   ],
          //                                 );
          //                               },
          //                               separatorBuilder:
          //                                   (BuildContext context, int index) {
          //                                 return const SizedBox(
          //                                   width: 27,
          //                                 );
          //                               },
          //                               //     children: [
          //                               //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
          //                               //       SizedBox(height: 2,),
          //                               //       Image.asset("assets/images/sun.png",scale: 1.6,),
          //                               //     ],
          //                               //   ),
          //                               //   SizedBox(height: 30,),
          //                               //   Sparkline(
          //                               //
          //                               //   //  gridLineAmount: 100,
          //                               //     min: -50,
          //                               //      max: 50,
          //                               //
          //                               //    pointIndex: 19,
          //                               //     // gridLineWidth: 50,
          //                               //     gridLineWidth:50,
          //                               //       //sharpCorners: true,
          //                               //       gridLineColor: Colors.white,
          //                               //     //  kLine: ['max', 'min', 'first', 'last'],
          //                               //      // fallbackWidth: 100,
          //                               //
          //                               //       lineColor: Colors.white,
          //                               //       pointSize: 4,
          //                               //       pointsMode: PointsMode.all,
          //                               //       pointColor: Colors.white,
          //                               //       //gridLineWidth: 10,
          //                               //       //averageLabel: true,
          //                               //     //  gridLineAmount: 5,
          //                               //       data: data)
          //                               //
          //                               // ],
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           height: 20,
          //                         ),
          //                         Expanded(
          //                           child: Padding(
          //                             padding: EdgeInsets.only(
          //                                 left: 30, right: 15, top: 15),
          //                             child: Sparkline(
          //
          //                               //  gridLineAmount: 100,
          //                                 min: -50,
          //                                 max: 50,
          //                                 gridLineAmount: 5,
          //                                 pointIndex: 1,
          //                                 //gridLineWidth: 50,
          //                                 // gridLineWidth:50,
          //                                 //sharpCorners: true,
          //                                 gridLineColor: Colors.white,
          //                                 //  kLine: ['max', 'min', 'first', 'last'],
          //                                 // fallbackWidth: 100,
          //
          //                                 lineColor: Colors.white,
          //                                 pointSize: 4,
          //                                 pointsMode: PointsMode.all,
          //                                 pointColor: Colors.white,
          //                                 //gridLineWidth: 10,
          //                                 //averageLabel: true,
          //                                 //  gridLineAmount: 5,
          //                                 data: BlocProvider.of<WeatherCubit>(context).temptoday
          //                                     .map((e) => e.toDouble())
          //                                     .toList()),
          //                           ),
          //                         ),
          //                         Expanded(
          //                           child: Container(
          //                             //height: 100,
          //                             padding: EdgeInsets.only(top: 5, left: 23),
          //                             child: ListView.separated(
          //                               //shrinkWrap: true,
          //                               physics: NeverScrollableScrollPhysics(),
          //
          //                               scrollDirection: Axis.horizontal,
          //                               itemCount: BlocProvider.of<WeatherCubit>(context).preception.length,
          //                               itemBuilder: (context, index) {
          //                                 return Row(
          //                                   children: [
          //                                     Image.asset(
          //                                       "assets/images/water.png",
          //                                       scale: 0.9,
          //                                       width: 17,
          //                                     ),
          //                                     Text(
          //                                       BlocProvider.of<WeatherCubit>(context).preception[index],
          //                                       style: TextStyle(
          //                                           color: Colors.white,
          //                                           fontSize: 11,
          //                                           fontWeight: FontWeight.bold),
          //                                     )
          //                                   ],
          //                                 );
          //                               },
          //                               separatorBuilder:
          //                                   (BuildContext context, int index) {
          //                                 return SizedBox(
          //                                   width: 55,
          //                                 );
          //                               },
          //                               //     children: [
          //                               //       Text("3 pm",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
          //                               //       SizedBox(height: 2,),
          //                               //       Image.asset("assets/images/sun.png",scale: 1.6,),
          //                               //     ],
          //                               //   ),
          //                               //   SizedBox(height: 30,),
          //                               //   Sparkline(
          //                               //
          //                               //   //  gridLineAmount: 100,
          //                               //     min: -50,
          //                               //      max: 50,
          //                               //
          //                               //    pointIndex: 19,
          //                               //     // gridLineWidth: 50,
          //                               //     gridLineWidth:50,
          //                               //       //sharpCorners: true,
          //                               //       gridLineColor: Colors.white,
          //                               //     //  kLine: ['max', 'min', 'first', 'last'],
          //                               //      // fallbackWidth: 100,
          //                               //
          //                               //       lineColor: Colors.white,
          //                               //       pointSize: 4,
          //                               //       pointsMode: PointsMode.all,
          //                               //       pointColor: Colors.white,
          //                               //       //gridLineWidth: 10,
          //                               //       //averageLabel: true,
          //                               //     //  gridLineAmount: 5,
          //                               //       data: data)
          //                               //
          //                               // ],
          //                             ),
          //                           ),
          //                         ),
          //                       ]),
          //                     ),
          //                   ]),
          //               //   SizedBox(height: 15,),
          //               //   Container(
          //               //     child: Center(
          //               //       child: RichText(
          //               //          textAlign: TextAlign.center,
          //               //         text:  TextSpan(
          //               //
          //               //             children:<TextSpan>[
          //               //             TextSpan(text: "Today's Temperature\n",
          //               //             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          //               //        TextSpan(text: "Expect the same as yesterday",
          //               //             style: TextStyle(color: Colors.white.withOpacity(0.6),)),
          //               //       ])
          //               //       ),
          //               //     ),
          //               //     // width:,
          //               //       height: 100,
          //               //
          //               //       decoration: BoxDecoration(
          //               //         color: Colors.white.withOpacity(0.4),
          //               //         borderRadius: BorderRadius.circular(20),
          //               //         border: Border.all(
          //               //           color: Colors.white.withOpacity(0.5),
          //               //           width: 1.0,
          //               //           style: BorderStyle.solid,
          //               //         ),
          //               //
          //               //
          //               //       )
          //               //
          //               //
          //               //   ),
          //               //
          //               //
          //               // ],
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //                 child: Center(
          //                   child: RichText(
          //                       textAlign: TextAlign.center,
          //                       text: TextSpan(children: <TextSpan>[
          //                         TextSpan(
          //                             text: "Today's Temperature\n",
          //                             style: TextStyle(
          //                                 color: Colors.white,
          //                                 fontWeight: FontWeight.bold)),
          //                         TextSpan(
          //                             text: "Expect the same as yesterday",
          //                             style: TextStyle(
          //                               color: Colors.white.withOpacity(0.6),
          //                             )),
          //                       ])),
          //                 ),
          //                 // width:,
          //                 height: 100,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white.withOpacity(0.4),
          //                   borderRadius: BorderRadius.circular(20),
          //                   border: Border.all(
          //                     color: Colors.white.withOpacity(0.5),
          //                     width: 1.0,
          //                     style: BorderStyle.solid,
          //                   ),
          //                 )),
          //             const SizedBox(
          //               height: 15,
          //             ),
          //             Container(
          //
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     //width:500,
          //                     height: 400,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white.withOpacity(0.4),
          //                       borderRadius: BorderRadius.circular(20),
          //                       border: Border.all(
          //                         color: Colors.white.withOpacity(0.5),
          //                         width: 1.0,
          //                         style: BorderStyle.solid,
          //                       ),
          //                     ),
          //                     //margin: EdgeInsets.only(left: 20,right: 15),
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 10.0,
          //                     ),
          //                     //padding: EdgeInsets.only(left: 5,),
          //                     child: Row(
          //                       children: [
          //                         Expanded(
          //                           child: ListView.separated(
          //                             // scrollDirection: Axis.vertical,
          //                               shrinkWrap: true,
          //                               // physics: NeverScrollableScrollPhysics(),
          //                               itemBuilder: (context, index) {
          //                                 return Text(
          //                                   BlocProvider.of<WeatherCubit>(context)
          //                                       .daystemp[index]["day"],
          //                                   style: const TextStyle(
          //                                     color: Colors.grey,
          //                                     fontWeight: FontWeight.w500,
          //                                   ),
          //                                 );
          //                               },
          //                               separatorBuilder: (context, index) {
          //                                 return SizedBox(height: 30);
          //                               },
          //                               itemCount:
          //                               BlocProvider.of<WeatherCubit>(context)
          //                                   .daystemp
          //                                   .length),
          //                         ),
          //                         Expanded(
          //                           child: ListView.separated(
          //                             //scrollDirection: Axis.vertical,
          //                               shrinkWrap: true,
          //                               // physics: NeverScrollableScrollPhysics(),
          //
          //                               itemBuilder: (context, index) {
          //                                 return Row(
          //                                   children: [
          //                                     Row(
          //                                       children: [
          //                                         Image.asset(
          //                                           "assets/images/water.png",
          //                                           scale: 0.9,
          //                                           width: 17,
          //                                         ),
          //                                         humdity[index],
          //                                       ],
          //                                     ),
          //                                     SizedBox(
          //                                       width: 3,
          //                                     ),
          //                                     Image.asset(
          //                                       "assets/images/sun.png",
          //                                       scale: 0.9,
          //                                       width: 30,
          //                                     ),
          //                                     SizedBox(
          //                                       width: 3,
          //                                     ),
          //                                     Image.asset(
          //                                       "assets/images/moon.png",
          //                                       scale: 0.9,
          //                                       width: 30,
          //                                     ),
          //                                     SizedBox(
          //                                       width: 3,
          //                                     ),
          //                                     Text(
          //                                       BlocProvider.of<WeatherCubit>(
          //                                           context)
          //                                           .daystemp[index]["maxtemp"]
          //                                           .toString(),
          //                                       style: TextStyle(
          //                                         color: Colors.grey,
          //                                         fontWeight: FontWeight.w500,
          //                                       ),
          //                                     ),
          //                                     SizedBox(
          //                                       width: 3,
          //                                     ),
          //                                     Text(
          //                                       BlocProvider.of<WeatherCubit>(
          //                                           context)
          //                                           .daystemp[index]["mintemp"]
          //                                           .toString(),
          //                                       style: TextStyle(
          //                                         color: Colors.grey,
          //                                         fontWeight: FontWeight.w500,
          //                                       ),
          //                                     )
          //                                   ],
          //                                 );
          //                               },
          //                               separatorBuilder: (context, index) {
          //                                 return SizedBox(height: 17);
          //                               },
          //                               itemCount:
          //                               BlocProvider.of<WeatherCubit>(context)
          //                                   .daystemp
          //                                   .length),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 15,
          //                   ),
          //                   Container(
          //                       width: double.infinity,
          //                       height: 200,
          //                       //margin: EdgeInsets.only(left: 20,right: 15),
          //                       padding: EdgeInsets.symmetric(
          //                         vertical: 40.0,
          //                       ),
          //                       //padding: EdgeInsets.only(left: 5,),
          //                       child: Center(
          //                         child: Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceAround,
          //                           children: [
          //                             Column(
          //                               children: [
          //                                 const Text(
          //                                   "Sunrise",
          //                                   style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.w500,
          //                                       fontSize: 15),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 2,
          //                                 ),
          //                                 Text(
          //                                     DateFormat.jm().format(DateTime
          //                                         .fromMillisecondsSinceEpoch(
          //                                         BlocProvider.of<WeatherCubit>(
          //                                             context)
          //                                             .cweather!
          //                                             .sys
          //                                             .sunrise *
          //                                             1000)),
          //                                     style: const TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                                 SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 Image.asset("assets/images/sunrise.png")
          //                               ],
          //                             ),
          //                             Column(
          //                               children: [
          //                                 Text("Sunset",
          //                                     style: TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                                 SizedBox(
          //                                   height: 2,
          //                                 ),
          //                                 Text(
          //                                     DateFormat.jm().format(DateTime
          //                                         .fromMillisecondsSinceEpoch(
          //                                         BlocProvider.of<WeatherCubit>(
          //                                             context)
          //                                             .cweather!
          //                                             .sys
          //                                             .sunset *
          //                                             1000)),
          //                                     style: const TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                                 const SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 Image.asset("assets/images/sunset.png")
          //                               ],
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                       decoration: BoxDecoration(
          //                         color: Colors.white.withOpacity(0.4),
          //                         borderRadius: BorderRadius.circular(20),
          //                         border: Border.all(
          //                           color: Colors.white.withOpacity(0.5),
          //                           width: 1.0,
          //                           style: BorderStyle.solid,
          //                         ),
          //                       )),
          //                   const SizedBox(
          //                     height: 15,
          //                   ),
          //                   Container(
          //                       width: double.infinity,
          //                       height: 200,
          //                       //margin: EdgeInsets.only(left: 20,right: 15),
          //                       padding: const EdgeInsets.symmetric(
          //                         vertical: 40.0,
          //                       ),
          //                       //padding: EdgeInsets.only(left: 5,),
          //                       child: Center(
          //                         child: Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceAround,
          //                           children: [
          //                             Column(
          //                               children: [
          //                                 Image.asset("assets/images/uv.png"),
          //                                 SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 Text(
          //                                   "Uv index",
          //                                   style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.w500,
          //                                       fontSize: 15),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 2,
          //                                 ),
          //                                 Text("High",
          //                                     style: TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                               ],
          //                             ),
          //                             Divider(),
          //                             Column(
          //                               children: [
          //                                 Image.asset("assets/images/wind.png"),
          //                                 SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 Text(
          //                                   "Wind",
          //                                   style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.w500,
          //                                       fontSize: 15),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 2,
          //                                 ),
          //                                 Text(
          //                                     BlocProvider.of<WeatherCubit>(context)
          //                                         .cweather!
          //                                         .wind
          //                                         .speed
          //                                         .toString() +
          //                                         " Km/h",
          //                                     style: const TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                               ],
          //                             ),
          //                             Divider(),
          //                             Column(
          //                               children: [
          //                                 Image.asset("assets/images/humidity.png"),
          //                                 SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 Text(
          //                                   "Humidity",
          //                                   style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.w500,
          //                                       fontSize: 15),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 2,
          //                                 ),
          //                                 Text(
          //                                     BlocProvider.of<WeatherCubit>(context)
          //                                         .cweather!
          //                                         .main
          //                                         .humidity
          //                                         .toString() +
          //                                         "%",
          //                                     style: TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.w500,
          //                                         fontSize: 15)),
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                       decoration: BoxDecoration(
          //                         color: Colors.white.withOpacity(0.4),
          //                         borderRadius: BorderRadius.circular(20),
          //                         border: Border.all(
          //                           color: Colors.white.withOpacity(0.5),
          //                           width: 1.0,
          //                           style: BorderStyle.solid,
          //                         ),
          //                       )),
          //                   SizedBox(
          //                     height: 800,
          //                   )
          //                 ],
          //               ),
          //             )
          //
          //           ],),
          //         )
          //
          //       ]),
          //     ),
          //   ]),
          // );
        }
      }),
    );
  }
}
