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
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Choose a Date"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
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
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white.withOpacity(0.15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        chooseStartDate(context);
                      },
                      child: Text('${displayDate(startDate)}'),
                    ),
                  ),
                ),
                Text(
                  'End Date:',
                  textScaleFactor: 2,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 75.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white.withOpacity(0.15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        chooseEndDate(context);
                      },
                      child: Text('${displayDate(endDate)}'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: const Color.fromARGB(255, 149, 215, 201)),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(15, 10, 12, 10)),
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 149, 215, 201)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          addPlaylists(context);
                        },
                        child: Text('+  Playlists',
                            style: TextStyle(
                                fontSize: 20
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: const Color.fromARGB(255, 149, 215, 201)),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(15, 10, 12, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 149, 215, 201)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            createDateEvent(eventsPriorityQueue, user);
                            Navigator.pop(context);
                          },
                          child: Text('Create Event',
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
            ),
          ),
          child: child!,
        );
      },
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
            ),
          ),
          child: child!,
        );
      },
    ))!;

    setState(() {
      endDate = chosenDate;
    });

  }

  void createDateEvent(PriorityQueue events, User user) {
    String eventListName = 'Event ' + (events.possibilities.length).toString();
    List<Event> eventList = [DateEvent(startDate, endDate, eventListName)];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.addItem(item);
  }

  String displayDate(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
  }

}
