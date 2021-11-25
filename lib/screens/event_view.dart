import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/slideable_actions.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/event_builders/location_event_builder.dart';
import 'package:sound_trek/screens/event_builders/time_event_builder.dart';
import 'package:sound_trek/screens/event_builders/weather_event_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sound_trek/screens/event_builders/date_event_builder.dart';
import 'package:sound_trek/models/user.dart';

class EventsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.black54,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          // automaticallyImplyLeading: true,
          title: const Text('Events'),
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.4,
                  1.0,
                ],
                colors: [Colors.black54, Color.fromARGB(255, 149, 215, 201)])),
        child: ListView.builder(
          itemCount: eventsPriorityQueue.possibilities.length,
          itemBuilder: (context, index) {
            final soundtrackItem = eventsPriorityQueue.possibilities[index];

            return Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => edit(eventsPriorityQueue, user, index),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) => delete(eventsPriorityQueue, index),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: buildListTile(soundtrackItem),
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Colors.white.withOpacity(0.7),
        activeBackgroundColor: Colors.white.withOpacity(0.5),
        activeForegroundColor: Colors.black54,
        foregroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 10,
        spaceBetweenChildren: 5,
        children: [
          SpeedDialChild(
              child: Icon(Icons.location_on_rounded),
              backgroundColor: Colors.white.withOpacity(0.7),
              labelBackgroundColor: Colors.white.withOpacity(0.7),
              foregroundColor: Colors.black,
              label: 'Location',
              labelStyle: TextStyle(color: Colors.black),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BuildLocationEvent();
                    })),
                  }),
          SpeedDialChild(
            child: Icon(Icons.access_time_filled_rounded),
            backgroundColor: Colors.white.withOpacity(0.7),
            labelBackgroundColor: Colors.white.withOpacity(0.7),
            foregroundColor: Colors.black,
            label: 'Time',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildTimeEvent();
              })),
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.event_note_rounded),
            backgroundColor: Colors.white.withOpacity(0.7),
            labelBackgroundColor: Colors.white.withOpacity(0.7),
            foregroundColor: Colors.black,
            label: 'Date',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildDateEvent();
              })),
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.wb_sunny_rounded),
            backgroundColor: Colors.white.withOpacity(0.7),
            labelBackgroundColor: Colors.white.withOpacity(0.7),
            foregroundColor: Colors.black,
            label: 'Weather',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildWeatherEvent();
              })),
            },
          )
        ],
      ),
    );
  }

  Widget buildListTile(SoundtrackItem item) {
    return Card (
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white.withOpacity(0.15),
      child: ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text(item.getEventList().elementAt(0).getName()),
      subtitle: Text(item.getEventList().elementAt(0).getType()),
      trailing: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 20,
      ),
      dense: false,
    ));
  }

  void edit(PriorityQueue events, User user, int index) {}

  void delete(PriorityQueue events, int index) {
    events.deleteItem(index);
  }

}
