import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import 'button.dart';

class SetStop{
  static DateTime? _curfew;
  static BehaviorSubject<DateTime?> curfewStream = BehaviorSubject.seeded(null);
  static set curfew(DateTime? value){
    _curfew = value;
    curfewStream.add(value);
  }

  static checkStop(){
    if(!ButtonController.active || _curfew == null){
      return;
    }
    if(DateTime.now().isAfter(_curfew!) && ButtonController.active){
      ButtonController.onPressed();
      curfew = null;
    }
  }

  static  bool parseCurfew(String value){
    log("parsing curfew");
    if(! value.startsWith("/")){
      return false;
    }
    try{
      int input = int.parse(value.substring(1));
      curfew = DateTime.now().add(Duration(minutes: input));
      log("curfew set to $_curfew");
      return true;
    }catch(e){
      curfew = null;
      log(e.toString());
    }
    return false;
  }

}