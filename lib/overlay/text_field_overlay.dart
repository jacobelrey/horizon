import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class TextFieldOverlay extends StatefulWidget {
  const TextFieldOverlay({Key? key}) : super(key: key);

  @override
  State<TextFieldOverlay> createState() => _TextFieldOverlayState();
}

class _TextFieldOverlayState extends State<TextFieldOverlay> {
  var _event;

  @override
  void initState() {
    super.initState();
    FlutterOverlayWindow.overlayListener.listen((event) {
      _event = event;
      setState(() {});
    });
  }
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) async {
        if (hasFocus) {
          await FlutterOverlayWindow.updateFlag(OverlayFlag.focusPointer);
        } else {
          await FlutterOverlayWindow.updateFlag(OverlayFlag.defaultFlag);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, //body: SafeArea ( child: Center (child:Text("Hello World")))
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            i++;
            setState(() {});
            },
          child: SafeArea(
            child: Center(
              child: Text("$_event")
            ),
          )
        )
      ),
    );
  }
}
