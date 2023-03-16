
import 'dart:ui';
import 'package:flutter/material.dart';

String shortcutInstruction = "- press shift+S to stop, shift+A to start\n(when application is in focus)";
String changeSpeedInstruction = "- to change the speed to NUMBER ms/copy\ntype \\NUMBER then press ENTER";
String autoStopInstruction = "- to stop after N minutes\ntype /N then press ENTER";
String version = "version: 1.0.0+4";
String instructionLabel = "$shortcutInstruction\n$changeSpeedInstruction\n$autoStopInstruction\n$version";
TextStyle smallLabelStyle = TextStyle(fontSize: 8);


SelectableText smallLabelText(String text){
  return SelectableText(text, textAlign: TextAlign.center ,style: smallLabelStyle);
}

Widget buttonPositioner(Widget child){
  return Container(child:
      child,
    padding: EdgeInsets.only(top: 20),);
}
Widget buttonContainer(Widget child){
  return Container(child:
      child,
      padding: EdgeInsets.only(bottom: 5),
  decoration: BoxDecoration(
  border: Border.all(color: Colors.white12, width: 2),
  borderRadius: BorderRadius.circular(0),
  ));
}
Widget speedStreamLabel(Stream<int> stream){
  return StreamBuilder<int>(
    stream: stream,
    builder: (context, snapshot) {
      return smallLabelText("speed: "+snapshot.data.toString() + "ms/copy");
    },
  );

}

Widget sleepStreamLabel(Stream<DateTime?> stream){
  return StreamBuilder<DateTime?>(
    stream: stream,
    builder: (context, snapshot) {
      DateTime? sleepTime = snapshot.data ?? null;
      String sleepTimeString = sleepTime == null ? "not set" : sleepTime.toIso8601String();
      return smallLabelText("auto stop: ${sleepTimeString.split(".")[0]}");
    },
  );

}