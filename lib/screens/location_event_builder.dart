import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildLocationEvent extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(
    title: const Text("Second Route"),
  ),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Go back!'),
      ),
    ),);
}