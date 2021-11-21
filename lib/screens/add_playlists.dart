import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/priority_queue.dart';

class AddPlaylists extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    Playlist playlist = Playlist();
    List<Playlist> playlistList = [];

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

          return buildListTile(playlist);
        },
      ),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 25),
          primary: Colors.white,
          backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        ),
        onPressed: () {
          Navigator.pop(context, playlist);
        },
        child: Text('Done'),
      ),
    );
  }

  Widget buildListTile(Playlist playlist) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text('${playlist}'),
      leading: Icon(
        Icons.toggle_off_outlined,
        color: Color(0xFF303030),
        size: 20,
      ),
      dense: false,
    );
  }
}
