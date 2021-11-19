import 'package:sound_trek/models/events/event.dart';

class WeatherEvent implements Event{

  //TODO: Replace String weather with weather relevant objects

  String _weather  = "";

  WeatherEvent(weatherIn){
    _weather = weatherIn;
  }

  //TODO: Replace this with real data, preferably a global variable that can be accessed from this object
  String currentWeather = ""; //Something like WeatherAPI.getWeather or whatever we end up using, this varible is here to prevent the check from nulling out below in isHappening

  @override
  bool isHappening(){
    if(currentWeather==_weather){
      return true;
    } else{
      return false;
    }
  }

  void setWeather(String locationIn){
    _weather = locationIn;
  }

  String getWeather(){
    return _weather;
  }

  @override
  String toString(){
    return "Weather: " + _weather.toString() + " " + isHappening().toString();
  }
}