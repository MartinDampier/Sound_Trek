import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/user.dart';

class DateEvent implements Event {

  @override
  bool isHappening(User user) {
    // TODO: implement isHappening
    throw UnimplementedError();
  }

  @override
  String getType(){
    return "Date";
  }

  @override
  bool getInitialized() {
    return true;
  }

  @override
  void setInitialized(initializedIn) {
  }

}