import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/soundtrack_item.dart';

class EventsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 149, 215, 201),
        // automaticallyImplyLeading: true,
        title: Text('Events'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
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
      body: ListView.builder(
        itemCount: eventsPriorityQueue.possibilities.length,
        itemBuilder: (context, index) {
          final soundtrackItem = eventsPriorityQueue.possibilities[index];

          return Slidable(
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
            child: buildListTile(soundtrackItem),
          );
        },
      ),
    );
  }

  Widget buildListTile(SoundtrackItem item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text('${item.getEventList().elementAt(0)}'),
      subtitle: Text('event type here...'),
      trailing: Icon(
        Icons.arrow_forward,
        color: Color(0xFF303030),
        size: 20,
      ),
      tileColor: Color(0xFFDADADA),
      dense: false,
    );
  }

  void edit(BuildContext context) {}

  void delete(BuildContext context) {}
}
