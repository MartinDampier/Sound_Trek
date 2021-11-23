import 'package:sound_trek/models/events/event.dart';

class DateEvent implements Event {

  @override
  bool isHappening() {
    // TODO: implement isHappening
    throw UnimplementedError();
  }

  @override
  String getType(){
    return "Date";
  }

}