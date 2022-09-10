import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/navigationDrawer.dart';

import '../screens/home_screen.dart';

class menuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      InkWell(
        onTap: (){
          scaffoldKey.currentState?.openDrawer();
         // return navigationDrawer();

        },
        child: Column(
        children: [
          Container(color: Colors.white,width: 16,height: 2,),
          SizedBox(height: 5,),
          Container(color: Colors.white,width: 16,height: 2,),
          SizedBox(height: 5,),
          Container(color: Colors.white,width: 16,height: 2,),
          SizedBox(height: 5,),


        ],

    ),
      );
  }
}
