import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:sound_trek/utilities/playlist_init.dart';
import 'package:location/location.dart';

class User with ChangeNotifier {
  Set<Circle> _circles = HashSet<Circle>();
  List<Playlist> usersPlaylists = PlaylistInit.getUserPlaylists();
  AudioPlayer _audioPlayer = AudioPlayer();
  late LatLng _currentLocation;
  String name = 'Lukas Frick';
  String email = 'lfrick3@lsu.edu';
  String image = 'assets/pictures/lukas.png';

  //new code
  void setCurrentLocation (LatLng coordinates) {
    _currentLocation = coordinates;
  }

  void setMusicPlayer(ConcatenatingAudioSource songs) {
    _audioPlayer.setAudioSource(
      songs,
      preload: false,
    );
  }

  LatLng getCurrentLocation(){
    return _currentLocation;
  }

  String getSongTitle() {
    int? index = _audioPlayer.currentIndex;
    if(index != null) {
      return _audioPlayer.sequence![index].tag.title;
    }
    else {return '';}
  }

  AudioPlayer getAudioPlayer() {
    return _audioPlayer;
  }

  void playMusic() {
    _audioPlayer.play();
  }

  void pauseMusic() {
    _audioPlayer.pause();
  }

  void previousMusic() {
    _audioPlayer.seekToPrevious();
  }

  void nextMusic() {
    _audioPlayer.seekToNext();
  }

  void repeatMusicOff() {
    _audioPlayer.setLoopMode(LoopMode.off);
  }

  void repeatMusicAll() {
    _audioPlayer.setLoopMode(LoopMode.all);
  }

  void repeatMusicOne() {
    _audioPlayer.setLoopMode(LoopMode.one);
  }

  void shuffleMusic() {
    _audioPlayer.setShuffleModeEnabled(true);
  }

  Set<Circle> getCircles() {
    return _circles;
  }

  void addCircle(Circle newCircle) {
    _circles.add(newCircle);
  }

  void removeCircle(int index) {}

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
