abstract class Event{

  bool isHappening(){
    throw Exception("Generic event handler was not overridden");
  }


}