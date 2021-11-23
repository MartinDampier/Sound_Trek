import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/user.dart';

class SoundtrackItem{

  late Playlist _playlist;
  List<Event> _eventList = [];

  SoundtrackItem(Playlist musicIn,List<Event> eventListIn){
    _playlist = musicIn;
    _eventList = eventListIn;
  }

  bool isHappening(User user){
    for(int i = 0; i<_eventList.length; i++){
      if(!_eventList.elementAt(i).isHappening(user)){
        return false;
      }
    }
    return true;
  }

  modifyItem(Playlist musicIn,List<Event> eventListIn){
    _playlist = musicIn;
    _eventList = eventListIn;
  }

  setPlaylist(Playlist musicIn){
    _playlist = musicIn;
  }

  Playlist getPlaylist(){
    return _playlist;
  }

  setEventList(List<Event> eventListIn){
    _eventList = eventListIn;
  }

  List<Event> getEventList(){
    return _eventList;
  }

  @override
  String toString(){
    return "Playlist: " + _playlist.toString() + "\n"+"Eventlist: "+ _eventList.toString();
  }
}