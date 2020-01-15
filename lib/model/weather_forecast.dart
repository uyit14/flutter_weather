import 'package:flutter_weather/model/list_forecast.dart';

import 'city.dart';
import 'list_forecast.dart';
class WeatherForeCast{
  String cod;
  int message;
  int cnt;
  List<ListForecast> list;
  City city;

  WeatherForeCast({this.cod, this.message, this.cnt, this.list, this.city});

  WeatherForeCast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = new List<ListForecast>();
      json['list'].forEach((v) {
        list.add(new ListForecast.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['message'] = this.message;
    data['cnt'] = this.cnt;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}