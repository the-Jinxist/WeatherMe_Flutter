import 'package:flutter/material.dart';
import 'ApiPage.dart';
import 'package:api_tutorial/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_tutorial/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchPageContainer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          primaryColorDark: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: "Montserrat"
      ),
      initialRoute: "/",
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      title: "Search Weather",
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController controller = new TextEditingController();
  String networkState = "idle";
  String locationValue = "";

  WeatherBloc weatherBloc = WeatherBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    weatherBloc.close();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: true,
            body: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
              child: BlocBuilder(
                bloc: weatherBloc,
                builder: (context, state){
                  return Column(
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
                            locationValue = string.trim();
                            weatherBloc.add(GetWeatherEvent(string.trim()));
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
                      Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: buildWidgetInResponseToStateChange(state)
                      ),

                      SizedBox(height: 10.0,),
                      InkWell(
                        onTap: (){
                          if(controller.text.trim().isNotEmpty){
                            locationValue = controller.text.trim();
                            weatherBloc.add(GetWeatherEvent(controller.text.trim()));
                          }
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
                            locationValue = controller.text.trim();
                            weatherBloc.add(GetWeatherEvent(controller.text.trim()));

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
                  );
                },

              ),
            ),
          );
  }

  Widget buildWidgetInResponseToStateChange(dynamic weatherState){
    if (weatherState is LoadingWeatherState){
      return Column(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 10.0),
            new Text("Finding weather details for: $locationValue",
              style: new TextStyle(
              fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white,
              ),
            ),
          ]
      );

    }else if(weatherState is GottenWeatherState){
      if (weatherState.weatherDetails != null){

        return
            InkWell(
              onTap: (){
                navigateToDetailsActivity(weatherState.weatherDetails);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("View Weather Details!",
                      style: new TextStyle(
                          fontFamily: "Montserrat", fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold
                      )
                  ),
                  SizedBox(width: 10.0,),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20.0,)
                ],
                ),
              ),
            );

      }else{
        return Column(
          children: <Widget>[
            SizedBox(height: 7.0),
            Text("Error! Can't find weather location for: $locationValue",
                style: new TextStyle(
                fontFamily: "Montserrat", fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 7.0),
          ],
        );
      }
    }

    else{
      return Container();
    }
  }

  void navigateToDetailsActivity(WeatherDetails weatherDetails) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ApiPage(weatherDetails: weatherDetails, location: locationValue,)));
  }

}

