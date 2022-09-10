import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businessLogic/cubit/cubit.dart';
import 'cardcity.dart';

class buildManageLocs extends StatefulWidget {
  List<Map> cities;
  buildManageLocs(
      {Key? key,

        required this.cities,

      })
      : super(key: key);

  @override
  State<buildManageLocs> createState() => _buildManageLocsState();
}

class _buildManageLocsState extends State<buildManageLocs> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (widget.cities
              .isNotEmpty)
            return CardCity(cweather: widget.cities[index]["cweather"],index: index,isfav:widget.cities[index]["isfav"],);
          else
            return Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10);
        },
        itemCount: widget.cities
            .length);
  }
}
