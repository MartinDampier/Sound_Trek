import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/user.dart';

class WeatherEvent implements Event{

  //TODO: Replace String weather with weather relevant objects

  String _weather  = "";
  String _name = "My Weather Event";

  WeatherEvent(weatherIn, String nameIn){
    _weather = weatherIn;
    _name = nameIn;
  }

  //TODO: Replace this with real data, preferably a global variable that can be accessed from this object
  String currentWeather = ""; //Something like WeatherAPI.getWeather or whatever we end up using, this varible is here to prevent the check from nulling out below in isHappening

  @override
  bool isHappening(User user){
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
  String getType(){
    return "Weather";
  }

  @override
  String toString(){
    return "Weather: " + _weather.toString();
  }

  @override
  String getName(){
    return _name;
  }

  @override
  bool getInitialized() {
    return true;
  }

  @override
  void setInitialized(initializedIn) {
  }
}