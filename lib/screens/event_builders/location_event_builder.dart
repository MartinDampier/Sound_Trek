import 'dart:collection';
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
import 'package:sound_trek/models/user.dart';

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
  late Playlist playlist;
  double eventRadius = 100;
  Set<Marker> _markers = HashSet<Marker>();

  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.40766724145041, -91.17953531915799),
    zoom: 14.4746,
  );

  LatLng _markerPosition = LatLng(30.40766724145041, -91.17953531915799);
  late LatLng _lastMapPosition;
  int _circleIdCounter = 1;

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
  }

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);

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
                  markers: _markers,
                  onCameraMove: _onCameraMove,
                  circles: user.getCircles(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 100
                            ? Colors.teal
                            : Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(100);
                      },
                      child: Text('100 meters'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 200
                            ? Colors.teal
                            : Color.fromARGB(255, 149, 215, 201),
                        // const Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(200);
                      },
                      child: Text('200 meters'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        primary: Colors.white,
                        backgroundColor: eventRadius == 500
                            ? Colors.teal
                            : Color.fromARGB(255, 149, 215, 201),
                      ),
                      onPressed: () {
                        setEventRadius(500);
                      },
                      child: Text('500 meters'),
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
                  createLocationEvent(eventsPriorityQueue, user);
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
    final Playlist chosenPlaylist =
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlaylists()),
    );

    setState(() {
      playlist = chosenPlaylist;
    });
  }

  void createLocationEvent(PriorityQueue events, User user) {
    _setCircles(user);
    String eventListName =
        'Event ' + (events.possibilities.length).toString();
    List<Event> eventList = [LocationEvent(_markerPosition.latitude as double, _markerPosition.longitude as double, eventRadius, eventListName, _circleIdCounter.toString())];

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
    _markers.add(
        Marker(
          draggable: true, // was set to true
          markerId: MarkerId("0"),
          position: _markerPosition,
          infoWindow: InfoWindow(
            title: "Your Event",
          ),
        )
    );
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

      _markerPosition = LatLng(
          _locationData.latitude as double, _locationData.longitude as double);
    });
  }

  Circle _displayCircles(user, lat, lng, rad) {
    final String circleIdVal = "$_circleIdCounter";
    _circleIdCounter++;
    return Circle(
        circleId: CircleId(circleIdVal),
        center: LatLng(lat.toDouble(), lng.toDouble()),
        radius: rad,
        //measured in meters
        fillColor: Color.fromRGBO(149, 215, 201, .4),
        strokeWidth: 2,
        strokeColor: Color.fromRGBO(149, 215, 201, 1));
  }

  void _setCircles(User user) {
    final String circleIdVal = "$_circleIdCounter";
    _circleIdCounter++;
    user.addCircle(
      Circle(
          circleId: CircleId(circleIdVal),
          center: _markerPosition,
          radius: eventRadius,
          //measured in meters
          fillColor: Color.fromRGBO(149, 215, 201, .4),
          strokeWidth: 2,
          strokeColor: Color.fromRGBO(149, 215, 201, 1)),
    );
  }

  void setMarkerLocation(LatLng location) {
    setState(() {
      _markerPosition = location;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _markerPosition = position.target;
    });
  }
}
