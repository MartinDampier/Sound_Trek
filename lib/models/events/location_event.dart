import 'package:SoundTrek/models/events/event.dart';

class LocationEvent implements Event{

  //TODO: Replace String location with location relevant objects

  String _location  = "";

  LocationEvent(locationIn){
    _location = locationIn;
  }

  //TODO: Replace this with real data, preferably a global variable that can be accessed from this object
  String currentLocation = "";

  @override
  bool isHappening(){
    if(currentLocation==_location){ //TODO: Verify this check runs
      return true;
    } else{
      return false;
    }
  }

  void setLocation(String locationIn){
    _location = locationIn;
  }

  String getLocation(){
    return _location;
  }

  @override
  String toString(){
    return "Location: " + _location.toString() + " " + isHappening().toString();
  }

}