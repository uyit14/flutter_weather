import 'dart:async';
import 'dart:convert';
import 'package:flutter_weather/model/weather_forecast.dart';
import 'package:flutter_weather/model/weather_today.dart';
import 'package:http/http.dart';

class WeatherApiProvider{
  Client _client = Client();
  //02d12f3623d749e35f096a218d430d3a
  //https://api.openweathermap.org/data/2.5/weather?q=New%20York&units=metric&appid=02d12f3623d749e35f096a218d430d3a
  //https://api.openweathermap.org/data/2.5/forecast?q=New%20York&units=metric&cnt=10&appid=02d12f3623d749e35f096a218d430d3a
  final _weatherApiKey = '02d12f3623d749e35f096a218d430d3a';
  final _baseUrl = 'https://api.openweathermap.org/data/2.5';
  Response response;

  //weather by city name
  Future<WeatherResponse> fetchWeatherByCityName(String _cityName) async{
    String url = "$_baseUrl/weather?q=$_cityName&units=metric&appid=$_weatherApiKey";
    response = await _client.get("$_baseUrl/weather?q=$_cityName&units=metric&appid=$_weatherApiKey");
    print(response.statusCode);
    print(url);
    switch(response.statusCode){
      case 200:
        return WeatherResponse.fromJson(json.decode(response.body));
        break;
      case 404:
        throw Exception('Server not found');
        break;
      default:
        throw Exception('Failed to load weather');
    }
  }

  //weather by location
  Future<WeatherResponse> fetchWeatherByLocation(double _latitute, double _longtitute) async{
    String url = "$_baseUrl/weather?lat=$_latitute&lon=$_longtitute&units=metric&appid=$_weatherApiKey";
    response = await _client.get("$_baseUrl/weather?lat=$_latitute&lon=$_longtitute&units=metric&appid=$_weatherApiKey");
    print(response.statusCode);
    print(url);
    switch(response.statusCode){
      case 200:
        return WeatherResponse.fromJson(json.decode(response.body));
        break;
      case 404:
        throw Exception('Server not found');
        break;
      default:
        throw Exception('Failed to load weather');
    }
  }

  //forecast by city name
  Future<WeatherForeCast> fetchWeatherForecastByCityName(String _cityName) async{
    String url = "$_baseUrl/forecast?q=$_cityName&units=metric&cnt=10&appid=$_weatherApiKey";
    response = await _client.get("$_baseUrl/forecast?q=$_cityName&units=metric&cnt=10&appid=$_weatherApiKey");
    print(response.statusCode);
    print(url);
    switch(response.statusCode){
      case 200:
        return WeatherForeCast.fromJson(json.decode(response.body));
        break;
      case 404:
        throw Exception("Server not found");
      default:
        throw Exception('Failed to load weather forecast');
    }
  }

  //forecast by location
  Future<WeatherForeCast> fetchWeatherForecastByLocation(double _latitute, double _longtitute) async{
    String url = "$_baseUrl/forecast?lat=$_latitute&lon=$_longtitute&units=metric&cnt=10&appid=$_weatherApiKey";
    response = await _client.get("$_baseUrl/forecast?lat=$_latitute&lon=$_longtitute&units=metric&cnt=10&appid=$_weatherApiKey");
    print(response.statusCode);
    print(url);
    switch(response.statusCode){
      case 200:
        return WeatherForeCast.fromJson(json.decode(response.body));
        break;
      case 404:
        throw Exception("Server not found");
      default:
        throw Exception('Failed to load weather forecast');
    }
  }
}