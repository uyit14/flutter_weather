import 'dart:async';

import 'package:flutter_weather/model/weather_forecast.dart';
import 'package:flutter_weather/model/weather_today.dart';
import 'package:flutter_weather/resources/weather_api_provider.dart';
class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<WeatherResponse> fetchWeatherByCityName(String _cityName) => weatherApiProvider.fetchWeatherByCityName(_cityName);
  Future<WeatherForeCast> fetchWeatherForecastByCityName(String _cityName) => weatherApiProvider.fetchWeatherForecastByCityName(_cityName);
}