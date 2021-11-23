import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/add_playlists.dart';
import 'package:sound_trek/models/events/clock_event.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/user.dart';

class BuildTimeEvent extends StatefulWidget {
  const BuildTimeEvent({Key? key}) : super(key: key);

  @override
  BuildTimeEventState createState() {
    return BuildTimeEventState();
  }
}

class BuildTimeEventState extends State<BuildTimeEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  late Playlist playlist;

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);

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
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 75.0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 149, 215, 201),
                  ),
                  onPressed: () {
                    addPlaylists(context);
                  },
                  child: Text('Add Playlists'),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 25),
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 149, 215, 201),
                ),
                onPressed: () {
                  // checkTimesValidity();
                  createTimeEvent(eventsPriorityQueue, user);
                  Navigator.pop(context);
                },
                child: Text('Create Event'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> addPlaylists (BuildContext context) async {
    final Playlist chosenPlaylist =
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlaylists()),
    );

    setState(() {
      playlist = chosenPlaylist;
    });
  }

  Future<void> chooseStartTime(BuildContext context) async {

    final chosenTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: Colors.teal)), child: child!);
      }
    ))!;

    setState(() {
      startTime = chosenTime;
    });

  }

  Future<void> chooseEndTime(BuildContext context) async {

    final chosenTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context,child) {
        return Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary:Colors.teal)), child: child!);
      }
    ))!;

    setState(() {
      endTime = chosenTime;
    });

  }

  void createTimeEvent(PriorityQueue events, User user) {
    String eventListName = 'Event ' + (events.possibilities.length + 1).toString();
    List<Event> eventList = [ClockEvent(displayTime(startTime).substring(0,5), displayTime(endTime).substring(0,5))];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.addItem(item);
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

    if (time.hour == 00) {
      hour = '12';
    }
    else if (time.hour > 12) {
      if (time.hour%12 < 10) {
        hour = (time.hour%12).toString().padLeft(2, '0');
      }
      else {hour = (time.hour%12).toString();}
    }
    else {
      if (time.hour < 10) {
        hour = (time.hour).toString().padLeft(2, '0');
      }
      else {hour = (time.hour).toString();}
    }

    if (time.minute < 10) {
      minute = time.minute.toString().padLeft(2, "0");
    }
    else {minute = time.minute.toString();}

    return hour + ':' + minute + ' ' + period;

  }

  // AlertDialog checkTimesValidity() {
  //   double startCheck = (startTime.hour + startTime.minute)/60.0;
  //   double endCheck = (endTime.hour + endTime.minute)/60.0;
  //
  //   if((endTime.period == DayPeriod.am && startTime.period == DayPeriod.pm) || (startTime.period == endTime.period && endCheck > startCheck)) {
  //     return AlertDialog (
  //       title: const Text('Invalid Times'),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: const <Widget>[
  //             Text('Please choose an end time later than the start time.')
  //           ],
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Close'),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ]
  //     );
  //   }
  //   else {}
  // }

}
