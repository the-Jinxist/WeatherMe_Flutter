import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherEvent extends WeatherEvent{

  final String location;

  @override
  // TODO: implement props
  List<Object> get props => [location];

  GetWeatherEvent(this.location);

}
