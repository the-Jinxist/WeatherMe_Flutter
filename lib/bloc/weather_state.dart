import 'package:equatable/equatable.dart';
import 'package:api_tutorial/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class LoadingWeatherState extends WeatherState{

  @override
  List<Object> get props => [];
}

class GottenWeatherState extends WeatherState{

  final WeatherDetails weatherDetails;

  @override
  List<Object> get props {
    return [weatherDetails];
  }

  GottenWeatherState(this.weatherDetails);


}
