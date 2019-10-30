import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {

  final String weatherDetail;
  final dynamic weatherDetailValue;
  final String weatherDetailsComment;

  WeatherDetail({this.weatherDetail, this.weatherDetailValue,
    this.weatherDetailsComment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(weatherDetail, textAlign: TextAlign.center, style: new TextStyle(
          fontFamily: "Montserrat", fontSize: 12.0, fontStyle: FontStyle.normal, color: Colors.white
          )
        ),
        Text(weatherDetailValue.toString(), textAlign: TextAlign.center, style: new TextStyle(
            fontFamily: "Montserrat", fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white
        ),),
        Text(weatherDetailsComment, textAlign: TextAlign.center, style: new TextStyle(
            fontFamily: "Montserrat", fontSize: 12.0, fontStyle: FontStyle.normal, color: Colors.white
        ),)
      ],
    );
  }
}
