// Flutter builtins
import 'package:flutter/material.dart';

// community libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// custom modules
import 'package:horizon/widgets/ModPhoto.dart';
import 'package:horizon/widgets/OpportunitiesView.dart';
import 'package:horizon/widgets/StatisticsView.dart';

class Profile extends StatefulWidget {

  String name = "Jacob";
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("${widget.name}\'s Profile")),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {},),
          actions: <Widget>[
            IconButton(icon: Icon(FontAwesomeIcons.rocket), 
            onPressed: () async {},),
          ],
        ),
        body: ListView (
          children: <Widget>[
            ModPhoto(widget.name),
            StatisticsView(),
            OpportunitiesView(),
          ]
        ), 
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
