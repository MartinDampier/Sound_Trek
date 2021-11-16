import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PlaylistsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
            title: Text('Playlist 1'),
            subtitle: Text('events associated here...'),
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

}
