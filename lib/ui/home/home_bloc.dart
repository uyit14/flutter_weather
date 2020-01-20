import 'package:flutter_weather/model/weather_forecast.dart';
import 'package:flutter_weather/model/weather_today.dart';
import 'package:flutter_weather/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();
  final _weatherResponse = PublishSubject<WeatherResponse>();
  final _weatherForecast = PublishSubject<WeatherForeCast>();

  Observable<WeatherResponse> get weatherByCityName => _weatherResponse.stream;
  Observable<WeatherForeCast> get weatherForecastByCityName => _weatherForecast.stream;
  Observable<WeatherResponse> get weatherByLocation => _weatherResponse.stream;
  Observable<WeatherForeCast> get weatherForecastByLocation => _weatherForecast.stream;

  fetchWeatherByCityName(String _cityName) async {
    WeatherResponse weatherResponse = await _repository.fetchWeatherByCityName(_cityName);
    _weatherResponse.sink.add(weatherResponse);
  }

  fetchWeatherForecastByCityName(String _cityName) async{
    WeatherForeCast weatherForeCast = await _repository.fetchWeatherForecastByCityName(_cityName);
    _weatherForecast.sink.add(weatherForeCast);
  }

  fetchWeatherByLocation(double _latitute, double _longtitute) async {
    WeatherResponse weatherResponse = await _repository.fetchWeatherByLocation(_latitute, _longtitute);
    _weatherResponse.sink.add(weatherResponse);
  }

  fetchWeatherForecastByLocation(double _latitute, double _longtitute) async{
    WeatherForeCast weatherForeCast = await _repository.fetchWeatherForecastByLocation(_latitute, _longtitute);
    _weatherForecast.sink.add(weatherForeCast);
  }

  void dispose(){
    _weatherForecast.close();
    _weatherResponse.close();
  }
}

final bloc = HomeBloc();