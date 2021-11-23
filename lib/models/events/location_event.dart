import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:geopointer/geopointer.dart';
import 'package:sound_trek/models/user.dart';

class LocationEvent implements Event{

  //TODO: Replace String location with location relevant objects

  String _name = "My Location Event";
  LatLng _location = LatLng(0,0);
  double _radius = 100;
  String _circleId = "";

  LocationEvent(double latIn, double longIn, double radiusIn, String nameIn, String circleIDIn){
    //_location = locationIn;
    _location = LatLng(latIn, longIn);
    _radius = radiusIn;
    _name = nameIn;
    _circleId = circleIDIn;
    print("Constructing Location Event");
  }

  @override
  bool isHappening(User user){
    LatLng userLocation = user.getCurrentLocation();
    final GDistance distance = new GDistance();
    num meter = distance(
        GeoLatLng(userLocation.latitude, userLocation.longitude),
        GeoLatLng(_location.latitude, _location.longitude)
    );
    print("Distance: " +meter.toDouble().toString()+ " " + _radius.toString());
    return ((meter.toDouble()).abs() < _radius);
  }

  void setLocation(double latIn, double longIn){
    _location = LatLng(latIn, longIn);
  }

  LatLng getLocation(){
    return _location;
  }

  void setRadius(double radiusIn){
    _radius = radiusIn;
  }

  double getRadius(){
    return _radius;
  }

  void setName(String nameIn){
    _name = nameIn;
  }

  @override
  String getName(){
    return _name;
  }

  @override
  String getType(){
    return "Location";
  }

  String getCircleID(){
    return _circleId;
  }

  void setCircleID(circleIDIn){
    _circleId = circleIDIn;
  }

  @override
  String toString(){
    return _name + " Location: " + _location.toString() + " Occuring: ";
  }

  @override
  bool getInitialized() {
    return true;
  }

  @override
  void setInitialized(initializedIn) {
  }

}