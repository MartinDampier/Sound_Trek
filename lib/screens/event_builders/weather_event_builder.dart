import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildWeatherEvent extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        title: const Text("Choose a Weather Condition"),
        centerTitle: true,
        elevation: 4,
      ),

      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(255, 149, 215, 201),
          ),
          onPressed: () {
            createWeatherEvent();
          },
          child: Text('Create Event'),
        ),
      ),
    );

  }

  void createWeatherEvent() {

  }

}