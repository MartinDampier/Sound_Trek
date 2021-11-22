import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/playlist.dart';

class PlaylistInit {

  static List<Playlist> getUserPlaylists () {
    return [
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
    ];;
  }

}