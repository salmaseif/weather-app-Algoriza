import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30,right: 20),
      child: Drawer(
        backgroundColor: Color(0xff2e3842),
        shape:  const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20)),
      ),

         child: Padding(
           padding: const EdgeInsets.all(30.0),
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
                       Text("Favourite Location ",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold),),
                     ],
                   ),

                   Icon(Icons.info_outline,color: Colors.white,size: 25),
                 ],
               ),
               SizedBox(height: 25,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Row(
                     children: [
                       Icon(Icons.location_on,color: Colors.white,size: 12,),
                       SizedBox(width: 2,),
                       Text("6 October",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                     ],
                   ),

                   Row(
                     children: [
                       Container(
                         width: 17,
                         height: 17,

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
                       Text("33°",style: TextStyle(color: Colors.white))
                     ],
                   ),

                 ],
               ),
               Divider(color: Colors.white,),
              SizedBox(height: 10,),
              // Icon()
               Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Icon(Icons.add_location,color: Colors.white,size: 25),
                   SizedBox(width: 20,),
                   Text("Other locations",style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold))


                 ],

               ),
               const SizedBox(height: 25,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text("Saint Catherine",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

                   Row(
                     children: [
                       Container(
                         width: 17,
                         height: 17,

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
                       Text("29°",style: TextStyle(color: Colors.white))
                     ],
                   ),

                 ],
               ),
               const SizedBox(height: 20,),
               Center(
                 child: MaterialButton(
                   height: 45,
                   minWidth: double.infinity,
                   color: Colors.grey,
                   shape: RoundedRectangleBorder(

                     borderRadius: BorderRadius.circular(15),



                   ),

                   onPressed: (){},
                   child: Text("Manage locations",
                       style: TextStyle(color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold)),),
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

         ),
      ),
    );
  }
}
