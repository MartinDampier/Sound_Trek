import 'package:sound_trek/models/priority_queue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:sound_trek/screens/event_view.dart';
import 'package:sound_trek/screens/playlist_view.dart';
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:just_audio/just_audio.dart';

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
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
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
  String _currentSongTitle = '';
  late Playlist _currentSong;

  Timer? timer;
  final Duration checkEventsInterval = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
    WidgetsBinding.instance?.addPostFrameCallback((_) => {checkForCurrentEvent(context)});
  }

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);

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
                    color: Colors.white,
                  ),
                  onPressed: () => _drawerKey.currentState?.openDrawer(),
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: Size(30.0, 30.0),
                  child: Container(
                      height: 30,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_currentSongTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
                  backgroundColor: const Color.fromARGB(255, 98, 98, 98),
                ),
                accountEmail: Text('${user.email}',
                  style: TextStyle(color: Colors.white,),
                ),
                accountName: Text(
                  '${user.name}',
                  style: TextStyle(fontSize: 24.0, color: Colors.white,),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 215, 201),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: const Text('Events',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 98, 98, 98),
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
                      color: const Color.fromARGB(255, 98, 98, 98),
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
                      color: const Color.fromARGB(255, 98, 98, 98),
                    )),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 98, 98, 98),
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
        circles: user.getCircles(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 149, 215, 201),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.loop_rounded,
                  color: Colors.white,
                    size: 30,
                ),
                onPressed: () {
                  user.repeatMusicAll();
                  //TODO: Make condition to alternate all LoopModes (refer to musicplayer_buttons.dart if it helps)
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  user.previousMusic();
                },
              ),
              IconButton(
                  icon: playMusicToggle
                      ? const Icon(
                          Icons.pause_rounded,
                          color: Colors.white,
                          size: 30,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                  onPressed: () {
                    setState(() {
                      playMusicToggle = !playMusicToggle;
                      if (playMusicToggle) {
                        _title = 'Currently playing...';
                        if(_currentSongTitle == '') {
                          _currentSong = user.usersPlaylists.elementAt(0);
                          user.usersPlaylists.elementAt(0).passToMusicPlayer(user);
                        }
                        user.playMusic();
                        _currentSongTitle = _currentSong.title;
                      } else {
                        user.pauseMusic();
                        _title = 'Music paused';
                        _currentSongTitle = '--';
                      }
                    });
                  }),
              IconButton(
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  user.nextMusic();
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.shuffle_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  user.shuffleMusic();
                }
              )
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

 // void loadPlaylists(User user) {
//
//   user.addPlaylist(Playlist(
//       ConcatenatingAudioSource(children: [
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
//       ]),
//         'Playlist 1'
//   ));
//
//   user.addPlaylist(Playlist(
//       ConcatenatingAudioSource(children: [
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
//       ]),
//       'Playlist 2'
//   ));
//
//   user.addPlaylist(Playlist(
//       ConcatenatingAudioSource(children: [
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
//       ]),
//       'Playlist 3'
//   ));
//
//   user.addPlaylist(Playlist(
//       ConcatenatingAudioSource(children: [
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
//       ]),
//       'Playlist 4'
//   ));
//
//   user.addPlaylist(Playlist(
//       ConcatenatingAudioSource(children: [
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
//         AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
//       ]),
//       'Playlist 5'
//   ));
//
// }


// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
