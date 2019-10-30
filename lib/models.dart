
class Coordinates {

  final double longitude;
  final double latitude;

  Coordinates({this.longitude, this.latitude});
}

class Weather{

  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({this.id, this.main, this.description, this.icon});
}

class Main{

  final double temperature;
  final int pressure;
  final int humidity;
  final double temperatureMinimum;
  final double temperatureMaximum;

  Main({this.temperature, this.pressure, this.humidity, this.temperatureMinimum,
      this.temperatureMaximum});
}

class Wind{
  final double speed;
  final int degree;

  Wind({this.speed, this.degree});
}

class Clouds{
  final int all;

  Clouds({this.all});
}

class Sys{

  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});
}

class WeatherDetails{

  final Coordinates coordinates;
  final Weather weather;
  final Wind wind;
  final String base;
  final Main main;
  final int visibility;
  final int dt;
  final Clouds clouds;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherDetails({this.coordinates, this.weather, this.base, this.main, this.visibility, this.dt, this.clouds
      , this.sys, this.timezone, this.id, this.name, this.cod, this.wind});


  factory WeatherDetails.getWeatherDetailsFromJson(Map<String, dynamic> json){

    Coordinates coordinates = Coordinates(latitude: json['coord']['lat'], longitude: json['coord']['lon']);
    Weather weather = Weather(id: json['weather'][0]['id'], main: json['weather'][0]['main']
        , description: json['weather'][0]['description'], icon: json['weather'][0]['icon']);
    Main main = Main(temperature: json['main']['temp'], pressure: json['main']['pressure'], humidity: json['main']['humidity'],
        temperatureMinimum: json['main']['temp_min'], temperatureMaximum: json['main']['temp_max']);
    Wind wind = Wind(speed: json['wind']['speed'], degree: json['wind']['deg']);
    Clouds clouds = Clouds(all: json['clouds']['all']);
    Sys sys = Sys(type: json['sys']['type'], id: json['sys']['id'], country: json['sys']['country'],
        sunrise: json['sys']['sunrise'], sunset: json['sys']['sunset']);

    int visibility = json['visibility'];
    int dt = json['dt'];
    String base = json['base'];
    int timezone = json['timezone'];
    int id = json['id'];
    String name = json['name'];
    int cod = json['cod'];

    return WeatherDetails(coordinates: coordinates, weather: weather, main: main, wind: wind, clouds: clouds, sys: sys,
    visibility: visibility, dt: dt, base: base, timezone: timezone, id: id, name: name, cod: cod);
  }


}