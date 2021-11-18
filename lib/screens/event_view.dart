import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:basic/screens/location_event_builder.dart';
import 'package:basic/screens/time_event_builder.dart';
import 'package:basic/screens/weather_event_builder.dart';

class EventsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        // automaticallyImplyLeading: true,
        title: const Text('Events'),
        actions: [
          Align(
            alignment: AlignmentDirectional(0, -0.05),
            child: GestureDetector(
              onTap: () { showEventSelector(context); },
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFDADADA),
      body: SafeArea(
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: edit,
                backgroundColor: Color(0xFF6B6B6B),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: delete,
                backgroundColor: Color(0xFF6B6B6B),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
            title: Text('Event 1'),
            subtitle: Text('event type here...'),
            trailing: Icon(
              Icons.arrow_forward,
              color: Color(0xFF303030),
              size: 20,
            ),
            tileColor: Color(0xFFDADADA),
            dense: false,
          ),
        ),
      ),
    );
  }

  void edit(BuildContext context) {

  }

  void delete(BuildContext context) {

  }

  void showEventSelector(BuildContext context) {
    Widget locationButton = TextButton(
      child: Text("Location"),
      onPressed:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BuildLocationEvent();
        }));
      },
    );

    Widget timeButton = TextButton(
      child: Text("Time"),
      onPressed:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BuildTimeEvent();
        }));
      },
    );

    Widget weatherButton = TextButton(
      child: Text("Weather"),
      onPressed:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BuildWeatherEvent();
        }));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Select an Event"),
      content: Text("remove this text"),
      actions: [
        locationButton,
        timeButton,
        weatherButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
