import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/add_playlists.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/events/location_event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class BuildLocationEvent extends StatefulWidget {
  const BuildLocationEvent({Key? key}) : super(key: key);

  @override
  BuildLocationEventState createState() {
    return BuildLocationEventState();
  }
}

class BuildLocationEventState extends State<BuildLocationEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late GoogleMapController _controller;
  Location _location = Location();
  bool _isServiceEnabled = false;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation = false;
  Playlist playlist = Playlist();
  double eventRadius = 0.5;

  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.40766724145041, -91.17953531915799),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
  }

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        title: const Text("Choose a Location and Radius"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 420,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 25),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 0.5 ? Colors.teal : Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(100);
                      },
                      child: Text('100 m'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 25),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 1.0 ? Colors.teal : Color.fromARGB(255, 149, 215, 201),
                            // const Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(200);
                      },
                      child: Text('200 m'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 25),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 5.0 ? Colors.teal : Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(500);
                      },
                      child: Text('500 m'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                    primary: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 149, 215, 201),
                  ),
                  onPressed: () {
                    addPlaylists(context);
                  },
                  child: Text('Add Playlists'),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 25),
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 149, 215, 201),
                ),
                onPressed: () {
                  createLocationEvent(eventsPriorityQueue);
                  Navigator.pop(context);
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addPlaylists(BuildContext context) async {
    final chosenPlaylist =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPlaylists();
    }));

    setState(() {
      playlist = chosenPlaylist;
    });
  }

  void createLocationEvent(PriorityQueue events) {
    String eventListName =
        'Event ' + (events.possibilities.length + 1).toString();
    List<Event> eventList = [LocationEvent(_location.toString())];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.addItem(item);
  }

  String displayLocation() {
    return _location.toString();
  }

  void setEventRadius(double radius) {
    setState(() {
      eventRadius = radius;
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
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
      _initialPosition = CameraPosition(
        target: LatLng(_locationData.latitude as double,
            _locationData.longitude as double),
        zoom: 15,
      );
    });
  }
}
