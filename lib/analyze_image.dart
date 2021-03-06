import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
class Analyze{

  Future<String> AnalyzeImage(File imageFile) async{
    List<String> labels = new List<String>();
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(imageFile);

    final CloudLabelDetector labelDetector = FirebaseVision.instance.cloudLabelDetector(CloudDetectorOptions(maxResults: 3));

    var currentLabel = await labelDetector.detectInImage(visionImage);

    if(currentLabel != null){
      
      print('----Copying Labels to String ---');
      
      for(Label label in currentLabel){
        String text = "";
        text = label.label;
        print("Labels: " + text);
        labels.add(text);
      }

    }
    else{
      throw Exception('Sorry! Could not analyze image!');
    }

    
    return labels[1];
    
  }

  
}