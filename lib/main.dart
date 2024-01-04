import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/accessibility_event.dart';
import 'package:flutter_accessibility_service/constants.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'package:horizon/overlay/Overlay.dart';
import 'package:horizon/pages/Profile.dart';
import 'package:horizon/overlay/text_field_overlay.dart';

import 'package:collection/collection.dart';

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: TextFieldOverlay(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

void accessibilityOverlay() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await FlutterOverlayWindow.isActive()) return;
  await FlutterOverlayWindow.showOverlay(
  enableDrag: false,
  overlayTitle: "X-SLAYER",
  overlayContent: 'Overlay Enabled',
  flag: OverlayFlag.clickThrough,
  visibility: NotificationVisibility.visibilityPublic,
  width: WindowSize.matchParent,
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<AccessibilityEvent>? _subscription;
  List<AccessibilityEvent?> events = [];
  DateTime eventDateTime = DateTime.now();
  bool foundSearchField = false;
  bool setText = false;
  bool clickFirstSearch = false;

  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    log("$res: OVERLAY");
    _receivePort.listen((message) {
      print("message from OVERLAY: $message");
      setState(() {
        latestMessageFromOverlay = 'Latest Message From Overlay: $message';
      });
    });
  }

  void handleAccessiblityStream() {
    foundSearchField = false;
    setText = false;
    if (_subscription?.isPaused ?? false) {
      _subscription?.resume();
      return;
    }
    _subscription =
        FlutterAccessibilityService.accessStream.listen((event) async {
      setState(() {
        events.add(event);
      });

      FlutterOverlayWindow.shareData(event);
      defeatInstagram(event);
    });
  }

  void handleOverlay(AccessibilityEvent event) async {
    if (event.packageName!.contains('instagram')) {
      log('$event');
    }
    if (event.packageName!.contains('instagram') && event.isFocused!) {
      eventDateTime = event.eventTime!;
      await FlutterAccessibilityService.showOverlayWindow();
    } else if (eventDateTime.difference(event.eventTime!).inSeconds.abs() > 2 ||
        (event.eventType == EventType.typeWindowStateChanged &&
            !event.isFocused!)) {
      await FlutterAccessibilityService.hideOverlayWindow();
    }
  }

  void automateWikipedia(AccessibilityEvent event) async {
    if (!event.packageName!.contains('wikipedia')) return;
    log('$event');
    final searchIt = [...event.subNodes!, event].firstWhereOrNull(
      (element) => element.text == 'Search Wikipedia' && element.isClickable!,
    );
    log("Searchable Field: $searchIt");
    if (searchIt != null) {
      await doAction(searchIt, NodeAction.actionClick);
      final editField = [...event.subNodes!, event].firstWhereOrNull(
        (element) => element.text == 'Search Wikipedia' && element.isEditable!,
      );
      if (editField != null) {
        await doAction(editField, NodeAction.actionSetText, "Lionel Messi");
      }
      final item = [...event.subNodes!, event].firstWhereOrNull(
        (element) => element.text == 'Messi–Ronaldo rivalry',
      );
      if (item != null) {
        await doAction(item, NodeAction.actionSelect);
      }
    }
  }

  void defeatInstagram(AccessibilityEvent event) async {
    if (!event.packageName!.contains('instagram')) return;
    log('$event');
    final searchIt = [...event.subNodes!, event].firstWhereOrNull(
      (element) => element.mapId!.contains('sponsored') && element.isClickable!,
    );
    if (searchIt != null) {
      await doAction(searchIt, NodeAction.actionScrollForward);
      }
  }

  Future<bool> doAction(
    AccessibilityEvent node,
    NodeAction action, [
    dynamic argument,
  ]) async {
    return await FlutterAccessibilityService.performAction(
      node,
      action,
      argument,
    );
  }

  void automateScroll(AccessibilityEvent node) async {
    if (!node.packageName!.contains('youtube')) return;
    log("$node");
    if (node.isFocused!) {
      final scrollableNode = findScrollableNode(node);
      log('$scrollableNode', name: 'SCROLLABLE- XX');
      if (scrollableNode != null) {
        await FlutterAccessibilityService.performAction(
          node,
          NodeAction.actionScrollForward,
        );
      }
    }
  }

  AccessibilityEvent? findScrollableNode(AccessibilityEvent rootNode) {
    if (rootNode.isScrollable! &&
        rootNode.actions!.contains(NodeAction.actionScrollForward)) {
      return rootNode;
    }
    if (rootNode.subNodes!.isEmpty) return null;
    for (int i = 0; i < rootNode.subNodes!.length; i++) {
      final childNode = rootNode.subNodes![i];
      final scrollableChild = findScrollableNode(childNode);
      if (scrollableChild != null) {
        return scrollableChild;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Profile(),
        floatingActionButton: FloatingActionButton(
          onPressed: accessibilityOverlay,
          child: Icon(Icons.add)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      )
      
    );
  }
}
