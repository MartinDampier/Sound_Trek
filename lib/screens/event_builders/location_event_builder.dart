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
  String _aubergineMapStyle = '';
  late Playlist playlist;
  double eventRadius = 100;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _radiusView = {};

  late CameraPosition _initialPosition;
  LatLng _markerPosition = LatLng(30.40766724145041, -91.17953531915799);

  @override
  void initState() {
    super.initState();
    _requestLocationPerms();
  }

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);
    initializeCamera(user);


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Choose a Location and Radius"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 420,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        markers: _markers = {Marker(
                          draggable: false, // was set to true
                          markerId: MarkerId("0"),
                          position: _markerPosition,
                          infoWindow: InfoWindow(
                            title: "Your Event Center",
                          ),
                        )},
                        onCameraMove: _onCameraMove,
                        circles: _radiusView.union(user.getCircles()),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text('Event Radius',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Slider(
                    value: eventRadius,
                    min: 5,
                    max: 500,
                    divisions: 11,
                    label: eventRadius.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        eventRadius = value;
                      });
                    },
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
    List<Event> eventList = [LocationEvent(_markerPosition.latitude as double, _markerPosition.longitude as double, eventRadius, eventListName, CircleId('$user.circleIdCounter'))];

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
    _loadMapStyles();
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
    final String circleIdVal = "$user.circleIdCounter";
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
    final String circleIdVal = "$user.circleIdCounter";
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

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _markerPosition = position.target;
      _radiusView.add(Circle(
        circleId: CircleId("radius"),
        center: _markerPosition,
        radius: eventRadius,
        fillColor: Color.fromARGB(149, 237, 133, 138),
        strokeWidth: 2,
        strokeColor: Color.fromARGB(149, 255, 166, 170),
      ));
    });
  }

  void initializeCamera(User user) {
    _initialPosition = CameraPosition(
      target: LatLng(user.getCurrentLocation().latitude, user.getCurrentLocation().longitude),
      zoom: 15,
    );
  }

  Future<void> _loadMapStyles() async {
    _aubergineMapStyle = await DefaultAssetBundle.of(context).loadString('assets/map_styles/aubergine.json');
    _controller.setMapStyle(_aubergineMapStyle);
  }
}
