import 'package:flutter/material.dart';
import 'ApiPage.dart';
import 'package:api_tutorial/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller = new TextEditingController();
  WeatherDetails weatherDetails = WeatherDetails();
  String networkState = "idle";
  String locationValue = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.amber,
        fontFamily: "Montserrat"
      ),
      initialRoute: "/",
      routes: {
        "api_page": (context) => ApiPage()
      },
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      title: "Search Weather",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          decoration: BoxDecoration(
              color: Colors.blue
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("WeatherMe", textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontFamily: "Montserrat", fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white
                    ),),
                  SizedBox(width: 2.0,),
                  Icon(Icons.wb_sunny, color: Colors.amber, size: 20.0,)
                ],
              ),
              SizedBox(height: 70.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Find out how the weather is like at your preferred location",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                controller: controller,
                cursorColor: Colors.white,
                style: new TextStyle(
                    fontFamily: "Montserrat", color: Colors.white, backgroundColor: Colors.transparent,
                    fontSize: 20.0
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (string){
                  if(string.trim().isNotEmpty){
                    setState(() {
                      networkState = "working";
                    });
                    locationValue = string.trim();
                    fetchWeatherDetails(string.trim());
                  }else{
                    setState(() {
                      networkState = "emptyString";
                    });
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Colors.white,),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0)
                    ),
                    hintText: "Your Location",
                    hintStyle: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white70,
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: (networkState == "working") ? Column(
                    children: <Widget>[CircularProgressIndicator(),
                    SizedBox(height: 10.0),
                    new Text("Finding weather details for: $locationValue", style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white,
                        ),
                    ),
                    SizedBox(height: 20.0),
                    ]
                  )
                    : (networkState == "done") ? Column(children: <Widget>[
                  SizedBox(height: 7.0),
                  Text("Done!", style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold
                  ) ),
                  SizedBox(height: 7.0),
                ],)
                    : (networkState == "error") ? Column(children: <Widget>[
                  SizedBox(height: 7.0),
                  Text("Error! Can't find weather location for; $locationValue", style: new TextStyle(
                    fontFamily: "Montserrat", fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: 7.0),
                ],): (networkState == "emptyString") ?Column(children: <Widget>[
                  SizedBox(height: 7.0),
                  Text("Error! Please input a location $locationValue", style: new TextStyle(
                      fontFamily: "Montserrat", fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: 7.0),
                ],):
                SizedBox(height: 0.0),
              ),
              SizedBox(height: 10.0,),
              InkWell(
                onTap: (){
                  if(controller.text.trim().isNotEmpty){
                    setState(() {
                      networkState = "working";
                    });
                    locationValue = controller.text.trim();
                    fetchWeatherDetails(controller.text);
                  }else{
                    setState(() {
                      networkState = "emptyString";
                    });
                  }
//                Navigator.push(context, MaterialPageRoute(builder: (context) => ApiPage()));
                },
                child: Card(
                  color: Colors.amber,
                  elevation: 10.0,
                  child: Container(
                    height: 40.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Weather Details",style: new TextStyle(
                            fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold
                        )
                        ),
                        SizedBox(width: 2.0,),
                        Icon(Icons.search, color: Colors.white, size: 20.0,)
                      ],
                    ),
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              InkWell(
                onTap: (){
                  if(controller.text.trim().isNotEmpty){
                    setState(() {
                      networkState = "working";
                    });
                    locationValue = controller.text.trim();
                    fetchWeatherDetails(controller.text);
                  }else{
                    setState(() {
                      networkState = "emptyString";
                    });
                  }
                },

                child: Card(
                  elevation: 10.0,
                  child: Container(

                    height: 40.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Your Location",style: new TextStyle(
                            fontFamily: "Montserrat", fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold
                        )
                        ),
                        SizedBox(width: 2.0,),
                        Icon(Icons.my_location, color: Colors.blue, size: 20.0,)
                      ],
                    ),
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchWeather(String name){

  }

  Future<WeatherDetails> fetchWeatherDetails(String location) async {
    try {
      final response =
      await http.get(
          'http://api.openweathermap.org/data/2.5/weather?q=$location&appid=bb17b57d2169e6ff5bfdd0983ce673bd');

      if (response.statusCode == 200) {
        setState(() {
          networkState = "done";
        });
        weatherDetails = WeatherDetails.getWeatherDetailsFromJson(
            json.decode(response.body));
        return weatherDetails;
      } else {
        setState(() {
          networkState = "error";
        });
        return null;
      }
    } catch (Exception) {
      setState(() {
        networkState = "error";
      });
      return null;
    }
  }
}
