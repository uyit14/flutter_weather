import 'package:flutter/material.dart';
import 'package:flutter_weather/common/datetime_convert.dart';
import 'package:flutter_weather/common/space_size.dart';
import 'package:flutter_weather/model/weather_today.dart';
import 'home_bloc.dart';

class HomeWeather extends StatefulWidget {
  @override
  _HomeWeatherState createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {

  @override
  void initState() {
    bloc.fetchWeatherByCityName("Tokyo");
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: bloc.weatherByCityName,
      builder: (context, snapshot) {
        WeatherResponse weatherResponse = snapshot.data;
        if(snapshot.hasData){
          return Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //top section
                Text(weatherResponse.name,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),),
                Text(DateTimeConvert.timeStampToDate(weatherResponse.dt), style: TextStyle(color: Colors.white),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wb_sunny, color: Colors.white,),
                    SizedBox(width: SpaceSize.spaceWidthSize(context, 0.025),),
                    Text(weatherResponse.weather[0].main, style: TextStyle(fontSize: 18,color: Colors.white),)
                  ],
                ),
                Text(weatherResponse.main.temp.toString() + "°C", style: TextStyle(fontSize: 72, color: Colors.white, fontWeight: FontWeight.w300),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(weatherResponse.main.tempMin.toString() + "°C", style: TextStyle(fontSize: 18, color: Colors.white),),
                    Text(weatherResponse.main.tempMax.toString() + "°C", style: TextStyle(fontSize: 18, color: Colors.white),)
                  ],
                ),
              ],
            ),
          );
        }else if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()),);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
