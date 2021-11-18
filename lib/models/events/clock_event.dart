import 'package:SoundTrek/models/events/event.dart';

class ClockEvent implements Event{

  String _startTime = "00:00";
  String _endTime = "00:00";
  Duration _duration = const Duration(minutes: 0);

  ClockEvent(String startTimeIn, String endTimeIn){
    _startTime = startTimeIn;
    _endTime = endTimeIn;
    _duration = _calculateDuration();
  }

  @override
  bool isHappening(){
    var now = DateTime.now();
    var startTimeUpdated = _buildTime(_startTime);
    var endTimeUpdated = startTimeUpdated.add(_duration);
    if(now.isAfter(startTimeUpdated) && now.isBefore(endTimeUpdated)){
      return true;
    }
    return false;
  }

  Duration _calculateDuration(){
    var startTimeUpdated = _buildTime(_startTime);
    var endTimeUpdated = _buildTime(_endTime);
    return startTimeUpdated.difference(endTimeUpdated);
  }

  DateTime _buildTime(String timeIn){
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, int.parse(_startTime.substring(0, timeIn.indexOf(":"))), int.parse(timeIn.substring(timeIn.indexOf(":")+1)), 0, 0);
  }

  int getDuration(){
    return _duration.inMinutes;
  }

  void setTimes(String startTimeIn, String endTimeIn){
    _startTime = startTimeIn;
    _endTime = endTimeIn;
    _duration = _calculateDuration();
  }

  @override
  String toString(){
    return "Start Time: " + _startTime + "\nEnd Time: " + _endTime + "\nDuration: " + _duration.toString();
  }
}