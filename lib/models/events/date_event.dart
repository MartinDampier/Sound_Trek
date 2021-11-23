import 'package:flutter/material.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:flutter/services.dart';
import 'package:sound_trek/models/user.dart';

class DateEvent implements Event{

  late DateTime _startTime;
  late DateTime _endTime;
  String _name = "My Date Event";

  DateEvent(DateTime startTimeIn, DateTime endTimeIn, String nameIn){
    if(startTimeIn.isBefore(endTimeIn)){
      _startTime = startTimeIn;
      _endTime = endTimeIn;
    }else{
      _startTime = endTimeIn;
      _endTime = startTimeIn;
    }
    _name = nameIn;
  }

  @override
  bool isHappening(User user){
    var now = DateTime.now();
    if(now.isAfter(_startTime) && now.isBefore(_endTime)){
      return true;
    }
    return false;
  }

  @override
  String getType(){
    return "Date Event";
  }

  @override
  String toString(){
    return "Start Time: " + _startTime.toString() + "\nEnd Time: " + _endTime.toString();
  }

  @override
  String getName(){
    return _name;
  }

  @override
  void setName(String nameIn){
    _name = nameIn;
  }



  @override
  bool getInitialized() {
    return true;
  }

  @override
  void setInitialized(initializedIn) {
  }


}