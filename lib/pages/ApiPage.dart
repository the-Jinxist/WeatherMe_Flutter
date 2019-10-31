import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_tutorial/models.dart';
import 'package:api_tutorial/widgets/WeatherDetail.dart';

class ApiPage extends StatefulWidget {

  final WeatherDetails weatherDetails;
  final String location;

  ApiPage({this.weatherDetails, this.location});

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {

  String networkState = "working";
  String location;

//  Double longitude;
//  Double latitude;

  @override
  Widget build(BuildContext context) {


//    longitude = widget.weatherDetails.coordinates.longitude;
//    latitude = widget.weatherDetails.coordinates.latitude;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("WeatherMe", textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontFamily: "Montserrat", fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white
                    ),),
                  SizedBox(width: 2.0,),
                  Icon(Icons.wb_sunny, color: Colors.amber, size: 20.0,)
                ],
              ),
              SizedBox(height: 50.0,),
              Text("Weather Details for ${widget.location}", textAlign: TextAlign.center, style: new TextStyle(
                fontFamily: "Montserrat", fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.underline
                ,)
              ),
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("${widget.weatherDetails.main.temperature}",textAlign: TextAlign.start, style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 100.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 5.0,),
                  Text("*F",textAlign: TextAlign.start, style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.amber
                  ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WeatherDetail(weatherDetail: "Maximum Temperature", weatherDetailsComment: "Mild", weatherDetailValue: "${widget.weatherDetails.main.temperatureMaximum} *F"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Minimum Tempeature", weatherDetailsComment: "Mild", weatherDetailValue: "${widget.weatherDetails.main.temperatureMinimum} *F"),

                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WeatherDetail(weatherDetail: "Humidity", weatherDetailsComment: "Low", weatherDetailValue: "${widget.weatherDetails.main.humidity}"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Wind Speed", weatherDetailsComment: "Fast", weatherDetailValue: "${widget.weatherDetails.wind.speed} km/h"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Pressure", weatherDetailsComment: "Normal", weatherDetailValue: "${widget.weatherDetails.main.pressure}"),

                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
//            fetchWeatherDetails(location);
          },
          elevation: 5.0,
          child: new Icon(Icons.refresh, color: Colors.white,),
          backgroundColor: Colors.amber,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}