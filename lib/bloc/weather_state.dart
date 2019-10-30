import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}
