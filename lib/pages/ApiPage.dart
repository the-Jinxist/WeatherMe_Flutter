import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_tutorial/models.dart';
import 'package:api_tutorial/widgets/WeatherDetail.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {

  String networkState = "working";
  String location;

  @override
  Widget build(BuildContext context) {
    location = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 100.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text("Temperature", textAlign: TextAlign.center, style: new TextStyle(
                    fontFamily: "Montserrat", fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white
                    ,)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("176",textAlign: TextAlign.start, style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 150.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 5.0,),
                  Text("*C",textAlign: TextAlign.start, style: new TextStyle(
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
                  WeatherDetail(weatherDetail: "Maximum Temperature", weatherDetailsComment: "Mild", weatherDetailValue: "178 *c"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Minimum Tempeature", weatherDetailsComment: "Mild", weatherDetailValue: "175 *c"),

                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WeatherDetail(weatherDetail: "Wind Speed", weatherDetailsComment: "Fast", weatherDetailValue: "20 km/h"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Wind Direction", weatherDetailsComment: "Low", weatherDetailValue: "30 deg"),
                  SizedBox(width: 20.0,),
                  WeatherDetail(weatherDetail: "Pressure", weatherDetailsComment: "Normal", weatherDetailValue: "12"),

                ],
              )


//              FutureBuilder(
//                future: fetchWeatherDetails(location),
//                builder: (context, snapshot){
//                  if (snapshot.hasData){
//                    WeatherDetails weatherDetails =  snapshot.data;
//
//                    return new Center(
//                      child: new Text("The temperature is: ${weatherDetails.main.temperature / 273}",style:
//                      new TextStyle(fontSize: 20.0, color: Colors.white)),
//                    );
//                  }else if (snapshot.hasError){
//                    return new Center(
//                      child: new Text("Sorry an error occured!: ${snapshot.error}",style:
//                      new TextStyle(fontSize: 20.0, color: Colors.white)),
//                    );
//                  }
//                  return Center(child: CircularProgressIndicator( backgroundColor: Colors.amber,));
//                }
//              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            fetchWeatherDetails(location);
          },
          elevation: 5.0,
          child: new Icon(Icons.refresh, color: Colors.white,),
          backgroundColor: Colors.amber,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<WeatherDetails> fetchWeatherDetails(String location) async{

    final response =
    await http.get('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=bb17b57d2169e6ff5bfdd0983ce673bd');

    if (response.statusCode == 200){
      setState(() {
        networkState = 'idle';
      });

      return WeatherDetails.getWeatherDetailsFromJson(json.decode(response.body));
    }else{
      setState(() {
        networkState = 'idle';
      });
      return null;
    }
  }
}