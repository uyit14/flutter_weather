import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/home/home_forecast.dart';
import 'package:flutter_weather/ui/home/home_weather.dart';
import 'package:flutter_weather/ui/search/search_page.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var icon = Icons.favorite_border;
  bool isFavorited = false;
  double latitute = 0.0, longtitute = 0.0;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<void> _getCurrentLocation() async{
    final locationData = await Location().getLocation();
    latitute = locationData.latitude;
    longtitute = locationData.longitude;
  }

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
  //goto search page
  void _gotoSearchPage(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_){
              return SearchPage();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(icon),
            onPressed: _changeIcon,
          ),
          SizedBox(width: 16,),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              _gotoSearchPage(context);
            },
          ),
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
                  HomeWeather(latitute, longtitute),
                  HomeForecast(latitute, longtitute)
                ],
              ),
            ),
      drawer: Drawer(
        child: Text("drawer"),
      ),
    );
  }
}
