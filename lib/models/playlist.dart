import 'package:collection/src/iterable_extensions.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/priority_queue.dart';

class Playlist {

  String title = 'Unnamed';
  String coverName = 'Image';
  late ConcatenatingAudioSource _songs;

  Playlist(ConcatenatingAudioSource songs, String name, String imageName) {
    _songs = songs;
    title = name;
    coverName = imageName;
  }

  void passToMusicPlayer (User user) {
    user.setMusicPlayer(_songs);
  }
  static String findAssociatedEvent(Playlist playlist, PriorityQueue events) {

    SoundtrackItem? associatedEvent = events.possibilities.firstWhereOrNull(
        ((item) => item.getPlaylist().title == playlist.title));

    if (associatedEvent == null) {
      return 'No event associated';
    } else {
      return associatedEvent.getEventList().elementAt(0).getName() + ' (' + associatedEvent.getEventList().elementAt(0).getType() + ')';
    }

  }


}