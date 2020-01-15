import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/common/datetime_convert.dart';
import 'package:flutter_weather/common/space_size.dart';
import 'package:flutter_weather/model/weather_forecast.dart';
import 'package:flutter_weather/model/weather_today.dart';
import 'package:flutter_weather/ui/home/home_bloc.dart';
import 'package:flutter_weather/ui/home/home_forecast.dart';
import 'package:flutter_weather/ui/home/home_weather.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var icon = Icons.favorite_border;
  bool isFavorited = true;

  @override
  void initState() {
    bloc.fetchWeatherForecastByCityName("Tokyo");
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _changeIcon(){
      if(!isFavorited){
        isFavorited = true;
        setState(() {
          icon = Icons.favorite;
        });
      }else{
        isFavorited = false;
        setState(() {
          icon = Icons.favorite_border;
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(icon),
            onPressed: _changeIcon,
          ),
          SizedBox(width: 16,),
          Icon(Icons.search),
          SizedBox(width: 16,),
          Icon(Icons.language),
          SizedBox(width: 4,)
        ],
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  HomeWeather(),
                  HomeForecast()
                ],
              ),
            ),
      drawer: Drawer(
        child: Text("drawer"),
      ),
    );
  }
}
