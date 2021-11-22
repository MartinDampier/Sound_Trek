import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/add_playlists.dart';
import 'package:sound_trek/models/events/date_event.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:intl/intl.dart';
import 'package:sound_trek/models/user.dart';

class BuildDateEvent extends StatefulWidget {
  const BuildDateEvent({Key? key}) : super(key: key);

  @override
  BuildDateEventState createState() {
    return BuildDateEventState();
  }
}

class BuildDateEventState extends State<BuildDateEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
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
        title: const Text("Choose a Date"),
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
                'Start Date:',
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 40),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    chooseStartDate(context);
                  },
                  child: Text('${displayDate(startDate)}'),
                ),
              ),
              Text(
                'End Date:',
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 75.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 40),
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    chooseEndDate(context);
                  },
                  child: Text('${displayDate(endDate)}'),
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
                  createDateEvent(eventsPriorityQueue, user);
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

  Future<void> chooseStartDate(BuildContext context) async {

    final DateTime chosenDate = (await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ))!;

    setState(() {
      startDate = chosenDate;
    });

  }

  Future<void> chooseEndDate(BuildContext context) async {

    final DateTime chosenDate = (await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ))!;

    setState(() {
      endDate = chosenDate;
    });

  }

  void createDateEvent(PriorityQueue events, User user) {
    String eventListName = 'Event ' + (events.possibilities.length + 1).toString();
    List<Event> eventList = [DateEvent()];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.addItem(item);
  }

  String displayDate(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
  }

}
