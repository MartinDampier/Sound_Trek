import 'package:basic/models/events/event.dart';
import 'package:basic/models/playlist.dart';
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