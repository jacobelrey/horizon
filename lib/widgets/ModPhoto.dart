import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModPhoto extends StatefulWidget {
  String name = "";

  ModPhoto(this.name);

  @override
  _ModPhotoState createState() => _ModPhotoState();
}

class _ModPhotoState extends State<ModPhoto> {
  String _name = '';
  File _image = File('');
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickMedia();
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    Navigator.pop(context, 'Cancel');
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
      return AlertDialog.adaptive(
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.pop(context, 'Cancel'); getImageFromCamera();}, icon: Icon(Icons.camera)),
          IconButton(onPressed: () {Navigator.pop(context, 'Cancel'); getImageFromGallery();}, icon: Icon(Icons.browse_gallery_rounded)),]
        
        );
});
  } 
    
    
    

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: showOptions,
          child: CircleAvatar(
            backgroundImage: Image.file(
              _image, 
              width: 500, 
              height: 500,
              fit:BoxFit.fill
            ).image,
            radius: 50,
          ),
        ),
        Flexible(child: Text("Hey ${widget.name}!, You have chosen to reevaluate your relationship with: Instagram, YouTube, Facebook.")),

      ],
    );
  }

}

