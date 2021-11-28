import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/playlist.dart';

import 'package:sound_trek/utilities/audio_metadata.dart';

class PlaylistInit {

  static List<Playlist> getUserPlaylists () {
    return [
      Playlist(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3'),
            tag: AudioMetadata(title: "Water"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),
              tag: AudioMetadata(title: "Town"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),
              tag: AudioMetadata(title: "Sadge"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3'),
              tag: AudioMetadata(title: "Lofi"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3'),
              tag: AudioMetadata(title: "Kleinstadt"),
            ),
          ]),
          'Flowing Vibes',
        'water.jpg'
      ),
      Playlist(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3'),
              tag: AudioMetadata(title: "Acoustic"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),
              tag: AudioMetadata(title: "Techno"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3'),
              tag: AudioMetadata(title: "Piano"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3'),
              tag: AudioMetadata(title: "Lofi"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),
              tag: AudioMetadata(title: "Irish"),
            ),
          ]),
          'Classy Acoustics',
        'acoustic.png'
      ),
      Playlist(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),
              tag: AudioMetadata(title: "Techno"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),
              tag: AudioMetadata(title: "Sadge"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3'),
              tag: AudioMetadata(title: "Piano"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3'),
              tag: AudioMetadata(title: "Kleinstadt"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),
              tag: AudioMetadata(title: "Irish"),
            ),
          ]),
          'Techno Beats',
        'techno.png'
      ),
      Playlist(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3'),
              tag: AudioMetadata(title: "Lofi"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3'),
              tag: AudioMetadata(title: "Acoustic"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),
              tag: AudioMetadata(title: "Town"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),
              tag: AudioMetadata(title: "Techno"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),
              tag: AudioMetadata(title: "Sadge"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3'),
              tag: AudioMetadata(title: "Life"),
            ),
          ]),
          'Chillfi',
        'lofi.png'
      ),
      Playlist(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3'),
              tag: AudioMetadata(title: "Kleinstadt"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),
              tag: AudioMetadata(title: "Irish"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),
              tag: AudioMetadata(title: "Town"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),
              tag: AudioMetadata(title: "Techno"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3'),
              tag: AudioMetadata(title: "Life"),
            ),
          ]),
          'German Jams',
        'kleinstadt.png'
      )
    ];
  }

}