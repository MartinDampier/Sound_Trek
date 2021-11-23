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
      'Playlist Default'), <Event> [DefaultEvent()])];

  int currentEventIndex = 0;

  SoundtrackItem Update(User user) {
    for(int i =0; i<possibilities.length;i++) {
      if (possibilities.elementAt(i).isHappening(user)) {
        return possibilities.elementAt(i);
      }
    }
    return possibilities.elementAt(0);
  }
  /*
  void FindStarterEvent(User user){
    print("Fell back on find starter");
    for(int i = 0; i< possibilities.length; i++){
      if(possibilities.elementAt(i).isHappening(user)){
        currentEventIndex = i;
        i = possibilities.length;
      }
    }
  }

  void Update(User user){
    print('Updating...');
    print(currentEventIndex.toString()+":" +"Current Event: " + possibilities.elementAt(currentEventIndex).getEventList().elementAt(0).toString());
    bool verifyEventOccurance = false;
    for(int i = 0; i<currentEventIndex+1; i++){
      if(possibilities.elementAt(i).isHappening(user)){
        print("isHappening: " + possibilities.elementAt(i).isHappening(user).toString() + "\n" + possibilities.elementAt(i).getEventList().toString());
        currentEventIndex = i;
        print(currentEventIndex.toString()+":"+possibilities.elementAt(currentEventIndex).getEventList().elementAt(0).toString() + " Is the new current");
        verifyEventOccurance = true;
        break;
      }
    }

    print("BADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBAD "+ possibilities.length.toString());
    for(int i = 0; i <possibilities.length; i++){
      print(i.toString() + ": "+ possibilities.elementAt(i).getEventList().elementAt(0).toString());
    }
    print("BADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBADBAD");

    if(verifyEventOccurance == false){
      FindStarterEvent(user);
    }
  }
*/
  void addItem(SoundtrackItem newItem) {
    print("Added Item");
    possibilities.insert(0, newItem);
    notifyListeners();
  }

  void deleteItem(int index) {
    possibilities.removeAt(index);
    notifyListeners();
  }

}