import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/add_playlists.dart';
import 'package:sound_trek/models/events/weather_event.dart';
import 'package:sound_trek/models/events/weather_handler.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/events/event.dart';

class BuildWeatherEvent extends StatefulWidget {
  const BuildWeatherEvent({Key? key}) : super(key: key);

  @override
  BuildWeatherEventState createState() {
    return BuildWeatherEventState();
  }
}

class BuildWeatherEventState extends State<BuildWeatherEvent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  WeatherCondition weatherCondition = WeatherCondition.unknown;
  Playlist playlist = Playlist();

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                child: DropdownButton<WeatherCondition>(
                  value: weatherCondition,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Color(0xFF6B6B6B)),
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 149, 215, 201),
                  ),
                  onChanged: (WeatherCondition? selectedCond) {
                    setState(() {
                      weatherCondition = selectedCond!;
                    });
                  },
                  items: <WeatherCondition>[
                    WeatherCondition.thunderstorm,
                    WeatherCondition.drizzle,
                    WeatherCondition.rain,
                    WeatherCondition.snow,
                    WeatherCondition.mist,
                    WeatherCondition.fog,
                    WeatherCondition.lightCloud,
                    WeatherCondition.heavyCloud,
                    WeatherCondition.clear,
                    WeatherCondition.unknown
                  ].map<DropdownMenuItem<WeatherCondition>>(
                      (WeatherCondition option) {
                    return DropdownMenuItem<WeatherCondition>(
                      value: option,
                      child: Text(displayWeather(option)),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
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
                  createWeatherEvent(eventsPriorityQueue);
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

  void createWeatherEvent(PriorityQueue events) {
    String eventListName = 'Event ' + (events.possibilities.length + 1).toString();
    List<Event> eventList = [WeatherEvent(displayWeather(weatherCondition))];

    SoundtrackItem item = SoundtrackItem(playlist, eventList);
    events.addItem(item);
  }

  String displayWeather(WeatherCondition weather) {
    return weather.toString().split('.').last;
  }
}
