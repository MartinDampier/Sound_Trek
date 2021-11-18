import 'package:basic/models/events/event.dart';
import 'package:basic/models/playlist.dart';

class SoundtrackItem{

  Playlist _playlist = Playlist();
  List<Event> eventList = [];

  SoundtrackItem(Playlist musicIn, List<Event> eventListIn){
    _playlist = musicIn;
    eventList = eventListIn;
  }

  bool isHappening(){
    for(int i = 0; i<eventList.length; i++){
      if(!eventList.elementAt(i).isHappening()){
        return false;
      }
    }
    return true;
  }

  modifyItem(Playlist musicIn,List<Event> eventListIn){
    _playlist = musicIn;
    eventList = eventListIn;
  }

  setPlaylist(Playlist musicIn){
    _playlist = musicIn;
  }

  Playlist getPlaylist(){
    return _playlist;
  }

  setEventList(List<Event> eventListIn){
    eventList = eventListIn;
  }

  List<Event> getEventList(){
    return eventList;
  }

  @override
  String toString(){
    return "Playlist: " + _playlist.toString() + "\n"+"Eventlist: "+ eventList.toString();
  }
}