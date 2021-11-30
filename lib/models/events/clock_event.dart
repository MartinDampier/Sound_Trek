import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:flutter/services.dart';
import 'package:sound_trek/models/user.dart';

class ClockEvent implements Event{

  late DateTime _startTime;
  late DateTime _endTime;
  String _name = "My Time of Day Event";

  ClockEvent(TimeOfDay startTimeIn, TimeOfDay endTimeIn, String nameIn){
    var now = DateTime.now();
    DateTime a =  DateTime(now.year, now.month, now.day, startTimeIn.hour, startTimeIn.minute);
    DateTime b =  DateTime(now.year, now.month, now.day, endTimeIn.hour, endTimeIn.minute);
    if(a.isBefore(b)){
      _startTime = a;
      _endTime = b;
    }else{
      _startTime = b;
      _endTime = a;
    }
    _name = nameIn;
  }

  @override
  bool isHappening(User user){
    var now = DateTime.now();
    if(now.isAfter(_startTime) && now.isBefore(_endTime.add(const Duration(minutes: 1)))){
      return true;
    }
    return false;
  }

  @override
  String getType(){
    return "Time of Day";
  }

  @override
  String toString(){
    return "Start Time: " + _startTime.toString() + "\nEnd Time: " + _endTime.toString();
  }

  @override
  String getName(){
    return _name;
  }

  void setName(String nameIn){
    _name = nameIn;
  }

  CircleId getCircleId() {
    return CircleId('none');
  }

  @override
  bool getInitialized() {
    return true;
  }

  @override
  void setInitialized(initializedIn) {
  }


}