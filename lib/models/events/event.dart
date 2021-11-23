import 'package:sound_trek/models/user.dart';

enum EventType{
  Time,
  Weather,
  Location
}


abstract class Event{

  bool isHappening(User user){
    throw Exception("Generic event handler was not overridden");
  }

  String getType(){
    return "Invalid Type";
  }


}