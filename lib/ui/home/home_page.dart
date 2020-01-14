import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/common/datetime_convert.dart';
import 'package:flutter_weather/common/space_size.dart';
import 'package:flutter_weather/model/weather_response.dart';
import 'package:flutter_weather/ui/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    bloc.fetchWeatherByCityName("New York City");
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Icon(Icons.favorite_border),
          SizedBox(width: 16,),
          Icon(Icons.search),
          SizedBox(width: 16,),
          Icon(Icons.language),
          SizedBox(width: 4,)
        ],
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: StreamBuilder<Object>(
        stream: bloc.weatherByCityName,
        builder: (context, snapshot) {
          WeatherResponse weatherResponse = snapshot.data;
          if(snapshot.hasData){
            return Container(
              color: Colors.blue,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(weatherResponse.name,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                    ),),
                  Text(DateTimeConvert.timeStampToDate(weatherResponse.dt), style: TextStyle(color: Colors.white),),
                  SizedBox(height: SpaceSize.spaceHeightSize(context, 0.1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wb_sunny, color: Colors.white,),
                      SizedBox(width: SpaceSize.spaceWidthSize(context, 0.025),),
                      Text(weatherResponse.weather[0].main, style: TextStyle(fontSize: 18,color: Colors.white),)
                    ],
                  ),
                  SizedBox(height: SpaceSize.spaceHeightSize(context, 0.1),),
                  Text(weatherResponse.main.temp.toString() + "°C", style: TextStyle(fontSize: 72, color: Colors.white, fontWeight: FontWeight.w300),),
                  SizedBox(height: SpaceSize.spaceHeightSize(context, 0.1),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(weatherResponse.main.tempMin.toString() + "°C", style: TextStyle(fontSize: 18, color: Colors.white),),
                      SizedBox(width: SpaceSize.spaceWidthSize(context, 0.1),),
                      Text(weatherResponse.main.tempMax.toString() + "°C", style: TextStyle(fontSize: 18, color: Colors.white),)
                    ],
                  ),
                  SizedBox(height: SpaceSize.spaceHeightSize(context, 0.1),),
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
                  )
                ],
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      drawer: Drawer(
        child: Text("drawer"),
      ),
    );
  }
}
