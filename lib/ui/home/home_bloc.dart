import 'package:flutter_weather/model/weather_response.dart';
import 'package:flutter_weather/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
class HomeBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherResponse>();

  Observable<WeatherResponse> get weatherByCityName => _weatherFetcher.stream;

  fetchWeatherByCityName(String _cityName) async {
    WeatherResponse weatherResponse = await _repository.fetchWeatherByCityName(_cityName);
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose(){
    _weatherFetcher.close();
  }
}

final bloc = HomeBloc();