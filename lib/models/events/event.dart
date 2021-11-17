abstract class Event{

  // String title = 'undefined';

  bool isHappening(){
    throw Exception("Generic event handler was not overridden");
  }

}