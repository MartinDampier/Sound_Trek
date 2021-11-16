import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:basic/screens/event_view.dart';
import 'package:basic/screens/playlist_view.dart';
import 'package:location/location.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  late GoogleMapController _controller;
  Location _location = Location();
  bool _isServiceEnabled = false;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation = false;
  static const CameraPosition _ourClass = CameraPosition(
    target: LatLng(30.40766724145041, -91.17953531915799),
    zoom: 14.4746,
  );
  bool playMusicToggle = false;
  String _title = 'Welcome to Sound Trek';
  String _currentSong = '';

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: Color.fromARGB(255, 149, 215, 201),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
              backgroundColor: const Color.fromARGB(255, 149, 215, 201),
              centerTitle: true,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_title,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ]),
              leading: Transform.scale(
                scale: 1.4,
                child: IconButton(
                  icon: const ImageIcon(
                    AssetImage('assets/logos/SoundTrek_Simplified.png'),
                    size: 150,
                  ),
                  onPressed: () => _drawerKey.currentState?.openDrawer(),
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: Size(50.0, 50.0),
                  child: Container(
                      height: 50,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(_currentSong,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 98, 98, 98),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]))))),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/logos/davyjones.jpg'),
                  backgroundColor: Colors.white,
                ),
                accountEmail: Text('i_am_davy@soundtrek.com'),
                accountName: Text(
                  'Davy Jones',
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 215, 201),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: Text('Events',
                    style: const TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EventsPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_music),
                title: Text('Playlists',
                    style: const TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        mapType: MapType.normal,
        initialCameraPosition: _ourClass,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 149, 215, 201),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.skip_previous_rounded,
                  color: Color.fromARGB(255, 98, 98, 98),
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                  icon: playMusicToggle
                      ? Icon(
                          Icons.pause_rounded,
                          color: Color.fromARGB(255, 98, 98, 98),
                          size: 30,
                        )
                      : Icon(
                          Icons.play_arrow_rounded,
                          color: Color.fromARGB(255, 98, 98, 98),
                          size: 30,
                        ),
                  onPressed: () {
                    setState(() {
                      playMusicToggle = !playMusicToggle;
                      if (playMusicToggle) {
                        _title = 'Currently playing...';
                        _currentSong = 'YTCracker - Bitcoin Baron';
                      } else {
                        _title = 'Music paused';
                        _currentSong = '--';
                      }
                    });
                  }),
              IconButton(
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: Color.fromARGB(255, 98, 98, 98),
                  size: 30,
                ),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude as double, l.longitude as double),
              zoom: 15),
        ),
      );
    });
  }

  Future<void> _requestLocationPerms() async {
    _isServiceEnabled = await _location.serviceEnabled();

    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      if (_isServiceEnabled) return;
    }

    _permissionStatus = await _location.requestPermission();

    if (_permissionStatus == PermissionStatus.denied) {
      _isServiceEnabled = await _location.requestService();
      if (_isServiceEnabled != PermissionStatus.granted) return;
    }

    _locationData = await _location.getLocation();

    setState(() {
      _isGetLocation = true;
    });
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
