import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpportunitiesView extends StatefulWidget {
  @override
  _OpportunitiesViewState createState() => _OpportunitiesViewState();
}

class _OpportunitiesViewState extends State<OpportunitiesView> {
  // String head = ['default', 'default', 'default'];
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 20),
      height: 400,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.brain)),
                Tab(icon: Icon(FontAwesomeIcons.heart)),
                Tab(icon: Icon(FontAwesomeIcons.peopleGroup)),
              ],
            ),
          ),
        body: TabBarView(
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextField(
                  controller: TextEditingController()..text ="Wash dog",
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),
                  ),  
                TextField(
                  controller: TextEditingController()..text ="Contact Immigration specialist", 
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  ), 
                TextField (
                  controller: TextEditingController()..text = "Pick up prescription", 
                  textAlign: TextAlign.left, 
                  scrollPadding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  )
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextField(
                  controller: TextEditingController()..text ="Get a coffee somewhere new",
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),
                  ),  
                TextField(
                  controller: TextEditingController()..text ="Make a next wrong turn, and see what you find", 
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  ), 
                TextField (
                  controller: TextEditingController()..text = "Discover something new about someone you love", 
                  textAlign: TextAlign.left, 
                  scrollPadding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  )
                ],
              ),              
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextField(
                  controller: TextEditingController()..text ="Jazz Session @ 38 Riv           9:15pm             12km",
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),
                  ),  
                TextField(
                  controller: TextEditingController()..text ="Standup @ HM Cafe               7:00pm              2.3km", 
                  textAlign: TextAlign.left, 
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  ), 
                TextField (
                  controller: TextEditingController()..text = "Lecture on Pyrrhus et Cineas 7:00pm              2.3km", 
                  textAlign: TextAlign.left, 
                  scrollPadding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: new InputDecoration(enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.5),)),  
                  )
                ],
              ),            ],
          ),  
        )
      )
    );
  }
}