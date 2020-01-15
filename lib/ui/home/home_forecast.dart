import 'package:flutter/material.dart';
import 'package:flutter_weather/common/datetime_convert.dart';
import 'package:flutter_weather/common/space_size.dart';
import 'package:flutter_weather/model/weather_forecast.dart';

import 'home_bloc.dart';

class HomeForecast extends StatefulWidget {
  @override
  _HomeForecastState createState() => _HomeForecastState();
}

class _HomeForecastState extends State<HomeForecast> {
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
    return Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //bottom section
          Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Text("Hourly forecast", style: TextStyle(color: Colors.white),)
              ),
              Expanded(
                  flex: 7,
                  child: Container(height: 1, color: Colors.white,)
              )
            ],
          ),
          StreamBuilder<Object>(
              stream: bloc.weatherForecastByCityName,
              builder: (context, snapshot) {
                WeatherForeCast weatherForecast = snapshot.data;
                if(snapshot.hasData){
                  return Container(
                    height: SpaceSize.spaceHeightSize(context, 0.25),
                    width: SpaceSize.spaceWidthSize(context, 1),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherForecast.list.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                color: index%2==0 ? Colors.green : Colors.red,
                                width: SpaceSize.spaceWidthSize(context, 0.4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(DateTimeConvert.timeStampToHours(weatherForecast.list[index].dtTxt), style: TextStyle(fontSize: 18, color: Colors.white),),
                                    Icon(Icons.wb_sunny, size: 32, color: Colors.white,),
                                    Text(weatherForecast.list[index].main.temp.toString() + "°C",style: TextStyle(fontSize: 18, color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  );
                }else if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                } else{
                  return Center(child: CircularProgressIndicator());
                }
              }
          )
        ],
      ),
    );
  }
}
