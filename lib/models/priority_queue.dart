import 'package:basic/models/soundtrack_item.dart';

class PriorityQueue{
  List<SoundtrackItem> _possibilities = [];
  int _currentEventIndex = 0;

  void FindStarterEvent(){
    for(int i = 0; i< _possibilities.length; i++){
      if(_possibilities.elementAt(i).isHappening()){
        _currentEventIndex = i;
        i = _possibilities.length;
      }
    }
  }

  void Update(){
    bool verifyEventOccurance = false;
    for(int i = 0; i<_currentEventIndex+1; i++){
      if(_possibilities.elementAt(i).isHappening()){
        _currentEventIndex = i;
        i = _possibilities.length;
        verifyEventOccurance = true;
      }
    }

    if(verifyEventOccurance == false){
      FindStarterEvent();
    }
  }


}