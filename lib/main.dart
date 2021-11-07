import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'audiofile.dart';
import 'musicplayer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Sound Trek',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 98, 98, 98),
        primarySwatch: Colors.blue,
        canvasColor: Colors.grey,
      ),
      home: MusicPlayer(),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
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
    return Scaffold
      (
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255,149, 215, 201),
        centerTitle: true,
        title: Text(widget.title, style: const TextStyle( color: Color.fromARGB(255, 98, 98, 98),)),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/logos/SoundTrek_Simplified.png'),
            size: 300,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),

      drawer: const Drawer(
        child: Text('Hello'),
      ),

      body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child: const Icon(Icons.menu, color: Color.fromARGB(255, 98, 98, 98)),
        backgroundColor: const Color.fromARGB(255,149, 215, 201),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }
}
