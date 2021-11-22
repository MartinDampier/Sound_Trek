import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class User with ChangeNotifier{

  Set<Circle> _circles = HashSet<Circle>();
  List<Playlist> usersPlaylists = [new Playlist()];
  String name = 'Lukas Frick';
  String email = 'lfrick3@lsu.edu';
  String image = 'assets/pictures/lukas.png';

  Set<Circle> getCircles() {
    return _circles;
  }

  void addCircle(Circle newCircle) {
    _circles.add(newCircle);
  }

  void removeCircle(int index) {

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