import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/priority_queue.dart';

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
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 149, 215, 201),
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget buildListTile(Playlist playlist, PriorityQueue events) {
    String associatedEvent = Playlist.findAssociatedEvent(playlist, events);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text('${playlist.title}'),
      subtitle: Text('${associatedEvent}'),
      trailing: Icon(
        Icons.arrow_forward,
        color: Color(0xFF303030),
        size: 20,
      ),
      dense: false,
    );
  }

  void edit(BuildContext context) {}

  void delete(BuildContext context) {}
}
