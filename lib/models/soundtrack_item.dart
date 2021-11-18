import 'package:SoundTrek/models/events/event.dart';
import 'package:SoundTrek/models/playlist.dart';

class SoundtrackItem{

  Playlist _playlist = Playlist();
  List<Event> _eventList = [];

  SoundtrackItem(Playlist musicIn,List<Event> eventListIn){
    _playlist = musicIn;
    _eventList = eventListIn;
  }

  bool isHappening(){
    for(int i = 0; i<_eventList.length; i++){
      if(!_eventList.elementAt(i).isHappening()){
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

  List<Event> getEventList(List<Event> eventListIn){
    return _eventList;
  }

  @override
  String toString(){
    return "Playlist: " + _playlist.toString() + "\n"+"Eventlist: "+ _eventList.toString();
  }
}