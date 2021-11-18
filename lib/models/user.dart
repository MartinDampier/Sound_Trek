import 'package:SoundTrek/models/events/clock_event.dart';
import 'package:SoundTrek/models/events/event.dart';
import 'package:SoundTrek/models/playlist.dart';
import 'package:SoundTrek/models/priority_queue.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier{

  List<Event> usersEvents = [new ClockEvent('03:00', '04:00'), new ClockEvent('06:00', '08:00')];
  List<Playlist> usersPlaylists = [];

  void addEvent(Event newEvent) {
    usersEvents.insert(0, newEvent);
    notifyListeners();
  }

  void deleteEvent(int index) {
    usersEvents.removeAt(index);
    notifyListeners();
  }

  void editEvent(int index) {
    notifyListeners();
  }

  void addPlaylist(Playlist newPlaylist) {
    usersPlaylists.insert(0, newPlaylist);
    notifyListeners();
  }

  void deletePlaylist(int index) {
    usersPlaylists.removeAt(index);
    notifyListeners();
  }

  void editPlaylist(int index) {
    notifyListeners();
  }


}