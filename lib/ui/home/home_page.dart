import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/home/home_forecast.dart';
import 'package:flutter_weather/ui/home/home_weather.dart';
import 'package:flutter_weather/ui/search/search_page.dart';
import 'package:location/location.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var icon = Icons.favorite_border;
  bool isFavorite = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    bloc.fetchWeatherByLocation(locationData.latitude, locationData.longitude);
    bloc.fetchWeatherForecastByLocation(locationData.latitude, locationData.longitude);
  }

  void _changeIcon() {
    if (!isFavorite) {
      isFavorite = true;
      setState(() {
        icon = Icons.favorite;
      });
    } else {
      isFavorite = false;
      setState(() {
        icon = Icons.favorite_border;
      });
    }
  }

  //goto search page
  void _gotoSearchPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
    //
    if(result!=null){
      bloc.fetchWeatherByCityName(result);
      bloc.fetchWeatherForecastByCityName(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(icon),
            onPressed: _changeIcon,
          ),
          SizedBox(
            width: 16,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _gotoSearchPage(context);
            },
          ),
          SizedBox(
            width: 16,
          ),
          Icon(Icons.language),
          SizedBox(
            width: 4,
          )
        ],
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[HomeWeather(), HomeForecast()],
        ),
      ),
      drawer: Drawer(
        child: Text("drawer"),
      ),
    );
  }
}
