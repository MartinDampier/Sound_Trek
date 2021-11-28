import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/events/default_event.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/events/event.dart';

class PriorityQueue with ChangeNotifier{

  List<SoundtrackItem> possibilities = [SoundtrackItem(Playlist(ConcatenatingAudioSource(children: [
    AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
    AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
    AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
    AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
    AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
  ]),
      'Playlist Default', 'default.png'), <Event> [DefaultEvent()])];

  int currentEventIndex = 0;

  SoundtrackItem Update(User user) {
    for(int i =0; i<possibilities.length;i++) {
      //print(possibilities.elementAt(i).getEventList().toString());
      if (possibilities.elementAt(i).isHappening(user)) {
        return possibilities.elementAt(i);
      }
    }
    return possibilities.elementAt(0);
  }


  void addItem(SoundtrackItem newItem) {
    possibilities.insert(0, newItem);
    notifyListeners();
  }

  void deleteItem(int index) {
    possibilities.removeAt(index);
    notifyListeners();
  }

}