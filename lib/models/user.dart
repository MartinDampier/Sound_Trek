import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class User with ChangeNotifier {
  Set<Circle> _circles = HashSet<Circle>();
  List<Playlist> usersPlaylists = [
    Playlist(
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
        ]),
        'Playlist 1'
    ),
    Playlist(
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
        ]),
        'Playlist 2'
    ),
    Playlist(
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
        ]),
        'Playlist 3'
    ),
    Playlist(
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
        ]),
        'Playlist 4'
    ),
    Playlist(
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
        ]),
        'Playlist 5'
    )
  ];
  AudioPlayer _audioPlayer = AudioPlayer();
  String name = 'Lukas Frick';
  String email = 'lfrick3@lsu.edu';
  String image = 'assets/pictures/lukas.png';

  void setMusicPlayer(ConcatenatingAudioSource songs) {
    _audioPlayer.setAudioSource(
      songs,
      preload: false,
    );
  }

  void playMusic() {
    _audioPlayer.play();
  }

  void pauseMusic() {
    _audioPlayer.pause();
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
