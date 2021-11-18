import 'package:basic/models/soundtrack_item.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:basic/models/user.dart';
import 'package:basic/models/playlist.dart';
import 'package:basic/models/priority_queue.dart';

class PlaylistsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 149, 215, 201),
        // automaticallyImplyLeading: true,
        title: Text('Playlists'),
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
        itemCount: user.usersPlaylists.length,
        itemBuilder: (context, index) {
          final playlist = user.usersPlaylists[index];

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
            child: buildListTile(playlist, eventsPriorityQueue),
          );
        },
      ),
    );
  }

  Widget buildListTile(Playlist playlist, PriorityQueue events) {
    String associatedEvent = findAssociatedEvent(playlist, events);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text('${playlist}'),
      subtitle: Text('${associatedEvent}'),
      trailing: Icon(
        Icons.arrow_forward,
        color: Color(0xFF303030),
        size: 20,
      ),
      tileColor: Color(0xFFDADADA),
      dense: false,
    );
  }

  String findAssociatedEvent(Playlist playlist, PriorityQueue events) {

    SoundtrackItem? associatedEvent = events.possibilities.firstWhereOrNull(
        ((item) => item.getPlaylist().title == playlist.title));

    if (associatedEvent == null) {
      return 'No event associated';
    } else {
      return associatedEvent.getEventList().elementAt(0).toString();
    }

  }

  void edit(BuildContext context) {}

  void delete(BuildContext context) {}
}
