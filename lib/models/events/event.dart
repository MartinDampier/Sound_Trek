import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_trek/models/user.dart';

abstract class Event{

  bool isHappening(User user){
    throw Exception("Generic event handler was not overridden");
  }

  String getType(){
    return "Invalid Type";
  }

  String getName(){
    return "Unimplemented Event";
  }

  CircleId getCircleId() {
    return CircleId('none');
  }

  void setInitialized(initializedIn){}

  bool getInitialized(){
    return false;
  }


}