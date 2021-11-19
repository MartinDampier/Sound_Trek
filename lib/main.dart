// ignore_for_file: prefer_const_constructors

import 'package:sound_trek/models/priority_queue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:sound_trek/screens/event_view.dart';
import 'package:sound_trek/screens/musicplayer.dart';
import 'package:sound_trek/screens/playlist_view.dart';
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/user.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PriorityQueue>(create: (_) => PriorityQueue()),
      ChangeNotifierProvider<User>(create: (_) => User()),
    ],
    child: const MyApp(),
  ));
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
      home: MyHomePage(title: 'Welcome to Sound Trek'),
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

  Timer? timer;
  final Duration checkEventsInterval = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
    WidgetsBinding.instance?.addPostFrameCallback((_) => {checkForCurrentEvent(context)});
    // checkForCurrentEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);
    final PageController controller = PageController(initialPage: 0);

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
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('${user.image}'),
                  backgroundColor: Colors.white,
                ),
                accountEmail: Text('${user.email}'),
                accountName: Text(
                  '${user.name}',
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 215, 201),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: const Text('Events',
                    style: TextStyle(
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
                title: const Text('Playlists',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PlaylistsPage();
                  }));
                },
              ),
              const ListTile(
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Account',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings',
                    style: TextStyle(
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
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: Color.fromARGB(255, 98, 98, 98),
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                  icon: playMusicToggle
                      ? const Icon(
                          Icons.pause_rounded,
                          color: Color.fromARGB(255, 98, 98, 98),
                          size: 30,
                        )
                      : const Icon(
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
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: Color.fromARGB(255, 98, 98, 98),
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.music_note_rounded,
                  color: Color.fromARGB(255, 98, 98, 98),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MusicPlayer();
                  }));
                },
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

  void checkForCurrentEvent(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    eventsPriorityQueue.FindStarterEvent();
    timer = Timer.periodic(checkEventsInterval, (Timer t) => eventsPriorityQueue.Update());
  }


// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
