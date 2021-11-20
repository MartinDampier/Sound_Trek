import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import '../../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sound_trek/models/events/clock_event.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/models/events/event.dart';

class BuildTimeEvent extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Start Time:',
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 50),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    chooseStartTime(context);
                  },
                  child: Text('${displayTime(startTime)}'),
                ),
              ),
              Text(
                'End Time:',
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 50),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    chooseEndTime(context);
                  },
                  child: Text('${displayTime(endTime)}'),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 25),
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 149, 215, 201),
                ),
                onPressed: () {
                  createTimeEvent(eventsPriorityQueue);
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseStartTime(BuildContext context) async {

    startTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;

  }

  Future<void> chooseEndTime(BuildContext context) async {

    endTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;

  }

  void createTimeEvent(PriorityQueue events) {
    Playlist playlist = Playlist();
    String eventListName = 'Event ' + (events.possibilities.length + 1).toString();
    List<Event> eventList = [ClockEvent(displayTime(startTime).substring(0,4), displayTime(endTime).substring(0,4))];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.possibilities.add(item);
  }

  String displayTime(TimeOfDay time) {
    String hour;
    String minute;
    String period;

    if (time.period == DayPeriod.am) {
      period = 'AM';
    } else {
      period = 'PM';
    }

    if (time.hour > 12) {
      hour = (time.hour%12).toString();
    }
    else {hour = time.hour.toString();}

    if (time.minute < 10) {
      minute = time.minute.toString().padLeft(2, "0");
    }
    else {minute = time.minute.toString();}

    return hour + ':' + minute + ' ' + period;

  }
}
