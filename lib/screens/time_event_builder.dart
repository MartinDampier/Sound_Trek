import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildTimeEvent extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now();
    // TimeOfDay setTime = await showTimePicker(context: context, currentTime: currentTime);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        title: const Text("Choose a Time"),
        centerTitle: true,
        elevation: 4,
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Start Time:'),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 50
                ),
                primary: Colors.black,
              ),
              onPressed: () {startTime = chooseTime(startTime, context);},
              child: Text('${displayTime(startTime)}'),
            ),
            Text('End Time:'),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 50
                ),
                primary: Colors.black,
              ),
              onPressed: () {endTime = chooseTime(endTime, context);},
              child: Text('${displayTime(endTime)}'),
            ),
          ],
        ),

      ),



    );
  }

  TimeOfDay chooseTime(TimeOfDay time, BuildContext context) {
    return TimeOfDay.now();
  }

  String displayTime(TimeOfDay time) {
    String period;
    if (time.period == DayPeriod.am) {
      period = 'AM';
    } else {
      period = 'PM';
    }

    return time.hour.toString() + ':' + time.minute.toString() + ' ' + period;
  }
}
