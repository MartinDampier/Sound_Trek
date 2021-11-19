import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier{

  List<Playlist> usersPlaylists = [new Playlist()];


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