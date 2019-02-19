import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutritionacts/nutrition_display.dart';
import 'analyze_image.dart';

class OpenGallery extends StatefulWidget {
  @override
  _OpenGalleryState createState() => _OpenGalleryState();
}

class _OpenGalleryState extends State<OpenGallery> {
  File _imageFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Camera"),
          centerTitle: true,
        ),
        body: Center(
          child: _imageFile == null
              ? Padding(
                  padding: EdgeInsets.only(top: 60.0), child: Text('Select an Image'))
              : Hero(
                  tag: 'Image',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox.fromSize(
                      size: Size.fromHeight(400.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Material(
                            elevation: 8.0,
                            shadowColor: Colors.black12,
                            child: Image.file(
                              _imageFile,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "Camera",
                icon: Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {
                  _getImage();
                },
                label: Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                ),
              ),
              FloatingActionButton.extended(
                  heroTag: "Folder",
                  label: Text("Analyze",
                      style: TextStyle(color: Colors.white70, fontSize: 16.0)),
                  icon: Icon(
                    Icons.filter_center_focus,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: _analyzeImage),
            ],
          ),
        ));
  }

  Future _getImage() async {
    if(_imageFile != null){
      _imageFile = null;
    }
    
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    } else
      return _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Please Select the image again')));
  }

  Future _analyzeImage() async{

    if (_imageFile != null) {
      
       Analyze analyzeObject = new Analyze();
    var labels = await analyzeObject.AnalyzeImage(_imageFile);
        //print("Label after Analyzation: " + labels);
    await new Future.delayed(const Duration(milliseconds: 2500));
    Navigator.push(context, CupertinoPageRoute(builder: (context) => DisplayNutrition(_imageFile, labels)));

    
    print(labels);
    } else
      return _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Please Select the image again')));
   

  }
}
