import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/models/user.dart';

class PriorityQueue with ChangeNotifier{

  List<SoundtrackItem> possibilities = [];
  int _currentEventIndex = 0;

  void FindStarterEvent(User user){
    for(int i = 0; i< possibilities.length; i++){
      if(possibilities.elementAt(i).isHappening(user)){
        _currentEventIndex = i;
        i = possibilities.length;
      }
    }
  }

  void Update(User user){
    bool verifyEventOccurance = false;
    for(int i = 0; i<_currentEventIndex+1; i++){
      if(possibilities.elementAt(i).isHappening(user)){
        _currentEventIndex = i;
        i = possibilities.length;
        verifyEventOccurance = true;
      }
    }

    if(verifyEventOccurance == false){
      FindStarterEvent(user);
    }
  }

  void addItem(SoundtrackItem newItem) {
    possibilities.add(newItem);
    notifyListeners();
  }

  void deleteItem(int index) {
    possibilities.removeAt(index);
    notifyListeners();
  }

}