
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatisticsView extends StatefulWidget {
  @override
  _StatisticsViewState createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 84,
      child: ListView(
  // This next line does the trick.
  scrollDirection: Axis.horizontal,
  children: <Widget>[
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Icon(FontAwesomeIcons.instagram)),
          Center(child: Text("0.2/1 hour used")),
          Center(child: Text("30 distractions blocked")),
          Center(child: Text ("Est. 1 hour saved")),
          ],
        ),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Icon(FontAwesomeIcons.facebook)),
          Center(child: Text("15/35 minutes used")),
          Center(child: Text("30 distractions blocked")),
          Center(child: Text ("Est. 2 hour saved")),
          ],
        ),
    ),
    Container (
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Icon(FontAwesomeIcons.youtube)),
          Center(child: Text("1.0/1.5 hour used")),
          Center(child: Text("30 distractions blocked")),
          Center(child: Text ("Est. 4 hour saved")),
          ],
        ),
),
    
  ],
),
    );
  }
}