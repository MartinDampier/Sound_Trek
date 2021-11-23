import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:geopointer/geopointer.dart';

class LocationEvent implements Event{

  //TODO: Replace String location with location relevant objects

  String _name = "default";
  LatLng _location = LatLng(0,0);
  double _radius = 100;
  String _circleId = "";

  LocationEvent(double latIn, double longIn, double radiusIn, String nameIn, String circleIDIn){
    //_location = locationIn;
    _location = LatLng(latIn, longIn);
    _radius = radiusIn;
    _name = nameIn;
    _circleId = circleIDIn;
  }

  @override
  bool isHappening(){
    final GDistance distance = new GDistance();
    _location;
    return true;
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
    return _name + " Location: " + _location.toString() + " Occuring:" + isHappening().toString();
  }

}