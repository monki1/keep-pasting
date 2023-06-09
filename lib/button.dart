

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:keep_pasting/set_stop.dart';
import 'package:rxdart/rxdart.dart';
import 'paste.dart';


double buttonFontSize = 35;

String stop = "||";
String start = "▶";
class ButtonController{
  static bool active = false;
  static Function callback = (){};
  static String get text => active ? stop : start;
  static Duration _intervalDuration = Duration(milliseconds: 1000);
  static set intervalDuration(Duration duration) {
    _intervalDuration = duration;
    interval.add(duration.inMilliseconds);
    if(typeTimer!=null){
      typeTimer!.cancel();
      typeTimer = timer;
    }
  }
  static BehaviorSubject<int> interval = BehaviorSubject.seeded(_intervalDuration.inMilliseconds);
  static BehaviorSubject<String> label = BehaviorSubject.seeded(start);
  static Timer? typeTimer;

  static Timer get timer => Timer.periodic(_intervalDuration, (timer) async {
    await metaV();
    SetStop.checkStop();
    log(_intervalDuration.inMilliseconds.toString() + "ms");
  });


  static Function onPressed = (){
    if (!active) {
      typeTimer= timer;
    } else {
      typeTimer?.cancel();
      typeTimer = null;
    }
    active = !active;
    label.add(text);
    callback();
  };

  static TextButton get button {
    return
    TextButton(
      onPressed: () async {
        onPressed();
      },
      child: StreamBuilder<String>(
        stream: label.stream,
        builder: (context, snapshot) {
          return Text(snapshot.data ?? start, style: TextStyle(fontSize: buttonFontSize.toDouble()));
        },
      )
    );
  }
}