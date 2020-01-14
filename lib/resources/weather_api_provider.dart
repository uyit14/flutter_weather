import 'dart:async';
import 'dart:convert';
import 'package:flutter_weather/model/weather_response.dart';
import 'package:http/http.dart';

class WeatherApiProvider{
  Client _client = Client();
  //02d12f3623d749e35f096a218d430d3a
  //https://api.openweathermap.org/data/2.5/weather?q=New%20York&units=metric&appid=02d12f3623d749e35f096a218d430d3a
  final _weatherApiKey = '02d12f3623d749e35f096a218d430d3a';
  final _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherResponse> fetchWeatherByCityName(String _cityName) async{
    Response response;
    response = await _client.get("$_baseUrl/weather?q=$_cityName&units=metric&appid=$_weatherApiKey");
    switch(response.statusCode){
      case 200:
        return WeatherResponse.fromJson(json.decode(response.body));
        break;
      case 404:
        throw Exception('Failed to load post');
        break;
      default:
        throw Exception('Failed to load post');
    }
  }
}