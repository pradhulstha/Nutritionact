import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutritionacts/analyze_image.dart';
import 'package:nutritionacts/nutrition_display.dart';

class OpenCamera extends StatefulWidget {
  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
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
          key: _scaffoldKey,
          appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Camera"),
        centerTitle: true,
      ),
          body: Center(
            child: _imageFile == null ? Padding(
                    padding: EdgeInsets.only(top: 60.0),
                      child: Text("Select an Image")) :
                  Hero(
                    tag: 'Image',
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox.fromSize(
                        size: Size.fromHeight(400.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Material(
                                elevation: 8.0,
                                shadowColor: Colors.black12,
                                child: Image.file(_imageFile, fit: BoxFit.cover,)),),
                      ),
                    )
                  ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: "Camera",
                icon: Icon(Icons.camera,color: Colors.white,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: (){
                  _getImage();
                },
                label: Text('Camera', style: TextStyle(color: Colors.white70, fontSize: 16.0),),
              ),
              FloatingActionButton.extended(
                heroTag: "Folder",
                label: Text("Analyze", style: TextStyle(color: Colors.white70, fontSize: 16.0)),
                icon: Icon(Icons.filter_center_focus,color: Colors.white,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: (){
                  _analyzeImage();
                },
              ),
            ],
          ),
      )
        );
      }
    
      Future _getImage() async{
      _imageFile = null;
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if(imageFile != null) {
          setState(() {
            _imageFile = imageFile;
          });
        
    }else
      return _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please Select the image again')));
  }

  void _analyzeImage() async{
    Analyze analyzeObject = new Analyze();
    var labels = await analyzeObject.AnalyzeImage(_imageFile);

    print("Label after Analyzation: " + labels);
    await new Future.delayed(const Duration(milliseconds: 1000));
    Navigator.push(context, CupertinoPageRoute(builder: (context) => DisplayNutrition(_imageFile, labels)));
    

    print(labels);
  }
 
}