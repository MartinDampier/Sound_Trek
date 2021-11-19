import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildLocationEvent extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(
    title: const Text("Location Event"),
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 149, 215, 201),
  ),
    body: const MyCustomForm(),);
}
class MyCustomForm extends StatelessWidget {
  const MyCustomForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}