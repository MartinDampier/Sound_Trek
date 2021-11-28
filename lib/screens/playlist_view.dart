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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          // automaticallyImplyLeading: true,
          title: Text('Playlists'),
          centerTitle: true,
          elevation: 4,
        ),
      ),
      backgroundColor: Colors.black54,
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
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: delete,
                    backgroundColor: Colors.transparent,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.7),
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget buildListTile(Playlist playlist, PriorityQueue events) {
    String associatedEvent = Playlist.findAssociatedEvent(playlist, events);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white.withOpacity(0.15),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        title: Text('${playlist.title}'),
        subtitle: Text('${associatedEvent}'),
        leading: Image(image: AssetImage('assets/album_covers/${playlist.coverName}')),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 20,
        ),
        dense: false,
      ),
    );
  }

  void edit(BuildContext context) {}

  void delete(BuildContext context) {}
}
