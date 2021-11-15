import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:basic/screens/event_view.dart';
import 'package:basic/screens/playlist_view.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Trek',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 98, 98, 98),
        primarySwatch: Colors.blue,
        canvasColor: Colors.grey,
      ),
      home: const MyHomePage(title: 'Welcome to Sound Trek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        centerTitle: true,
        title: Text(widget.title,
            style: const TextStyle(
              color: Colors.white,
            )),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/logos/SoundTrek_Simplified.png'),
            size: 300,
          ),
          onPressed: () => _drawerKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/logos/SoundTrek_Full_Logo.png'),
                  backgroundColor: Colors.white,
                ),
                accountEmail: Text('i_am_davie@soundtrek.com'),
                accountName: Text(
                  'Davie Jones',
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 215, 201),
                ),
              ),
              // DrawerHeader(
              //   child: Text('Menu',
              //   style: const TextStyle (
              //     color: Colors.white,
              //   )),
              // ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: Text('Events',
                style: const TextStyle (
                  color: Colors.white,
                )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) {
                    return EventsPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_music),
                title: Text('Playlists',
                style: const TextStyle (
                  color: Colors.white,
                )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute (builder: (context) {
                    return PlaylistsPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: Text('Account',
                style: const TextStyle(
                  color: Colors.white,
                )),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text('Settings',
                style: const TextStyle(
                  color: Colors.white,
                )),
              ),
            ],
          ),
        ),
      ),

      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
