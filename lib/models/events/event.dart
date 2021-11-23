enum EventType{
  Time,
  Weather,
  Location
}


abstract class Event{

  bool isHappening(){
    throw Exception("Generic event handler was not overridden");
  }

  String getType(){
    return "Invalid Type";
  }


}