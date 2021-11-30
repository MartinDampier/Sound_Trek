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
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/awakening.mp3'),
              tag: AudioMetadata(title: "Awakening"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/flight loop.mp3'),
              tag: AudioMetadata(title: "Flight Loop"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/fluidity.mp3'),
              tag: AudioMetadata(title: "Fluidity"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/forme.mp3'),
              tag: AudioMetadata(title: "For Me"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/introvert.mp3'),
              tag: AudioMetadata(title: "Introvert"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/nameless.mp3'),
              tag: AudioMetadata(title: "Nameless"),
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
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/celtic.mp3'),
              tag: AudioMetadata(title: "Celtic"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/classical.mp3'),
              tag: AudioMetadata(title: "Classical"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/forelise.mp3'),
              tag: AudioMetadata(title: "Fur Elise"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),
              tag: AudioMetadata(title: "Irish"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3'),
              tag: AudioMetadata(title: "Life"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3'),
              tag: AudioMetadata(title: "Piano"),
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
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/axon.mp3'),
              tag: AudioMetadata(title: "Axon"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/jungleBass.mp3'),
              tag: AudioMetadata(title: "Jungle Bass"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/nightnday.mp3'),
              tag: AudioMetadata(title: "Night N Day"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/pandemic.mp3'),
              tag: AudioMetadata(title: "Pandemic"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/retroWave.mp3'),
              tag: AudioMetadata(title: "Retro Wave"),
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
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/beethoven.mp3'),
              tag: AudioMetadata(title: "Beeth Oven"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/dreaming.mp3'),
              tag: AudioMetadata(title: "Dreaming"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/foodVlog.mp3'),
              tag: AudioMetadata(title: "Food Vlog"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),
              tag: AudioMetadata(title: "Sadge"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),
              tag: AudioMetadata(title: "Town"),
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
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/minuet.mp3'),
              tag: AudioMetadata(title: "Minuet"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/germanOpera.mp3'),
              tag: AudioMetadata(title: "German Opera"),
            ),
            AudioSource.uri(Uri.parse('asset:///assets/musicsample/moonlightSonata.mp3'),
              tag: AudioMetadata(title: "Moonlight Sonata"),
            ),
          ]),
          'German Jams',
        'kleinstadt.png'
      )
    ];
  }

}