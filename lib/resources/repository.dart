import 'dart:async';

import 'package:flutter_weather/model/weather_response.dart';
import 'package:flutter_weather/resources/weather_api_provider.dart';
class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<WeatherResponse> fetchWeatherByCityName(String _cityName) => weatherApiProvider.fetchWeatherByCityName(_cityName);
}