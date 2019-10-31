import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:api_tutorial/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherEvent){
      yield new LoadingWeatherState();
      WeatherDetails weatherDetails = await fetchWeatherDetails(event.location);
      yield new GottenWeatherState(weatherDetails);
    }
  }

  Future<WeatherDetails> fetchWeatherDetails(String location) async {
    try {
      final response =
      await http.get(
          'http://api.openweathermap.org/data/2.5/weather?q=$location&appid=bb17b57d2169e6ff5bfdd0983ce673bd');

      if (response.statusCode == 200) {

        var weatherDetails = WeatherDetails.getWeatherDetailsFromJson(
            json.decode(response.body));
        return weatherDetails;
      } else {

        return null;
      }
    } catch (Exception) {

      return null;
    }
  }
}
