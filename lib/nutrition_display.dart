import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nutritionacts/bloc/nutrition_bloc.dart';
import 'package:nutritionacts/model/nutrition.dart';
import 'package:firebase_core/firebase_core.dart';

class DisplayNutrition extends StatefulWidget {
  final File _imageFile;
  final String label;

  DisplayNutrition(this._imageFile, this.label);

  @override
  DisplayNutritionState createState() {
    return new DisplayNutritionState();
  }
}

class DisplayNutritionState extends State<DisplayNutrition> {

 FirebaseDatabase database;
 final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("test");

 Map<dynamic, dynamic> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);  
    print("Printing Snapshot:" );
    database.reference().child("Apple").once().then((DataSnapshot snapshot){
      print("Inside Database");
      setState(() {
       data = snapshot.value; 
      });
      print(snapshot.value);
    });
    // databaseReference.once().then((DataSnapshot snapshot){
    //   print(data);
    // });
    //nutritionbloc.fetchNutrition(widget.label);
    
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: GlobalKey(),
        appBar: AppBar(
          title: Text("Nutrition Facts"),
        ),
        body: Column(
          children: <Widget>[
            Hero(
                tag: 'Image',
                child: Container(
                    height: 250.0,
                    child: Image.file(
                      widget._imageFile,
                      fit: BoxFit.cover,
                    ))),
                    buildList(),  //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: StreamBuilder(
    //             initialData: Nutrition(Caffiene: "O", Calories: "O", Carbohydrates: "o", Cholesterol: "o", Description: "o", Fat: "o", Potassium: "o", Protein: "o", Sodium: "o"),
    //   stream: nutritionbloc.allNutritionFacts,
    //   builder: (context, AsyncSnapshot<Nutrition> snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.active:
    //       case ConnectionState.none:
    //       case ConnectionState.waiting:
    //         return Align(
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator());
    //       case ConnectionState.done:
    //         {
    //           if (snapshot.hasError) {
    //             return Text(snapshot.error.toString());
    //           }else if (snapshot.hasData) {
                
    //             return buildList(snapshot.data);
    //           } 
    //         }
    //     }
    //   },
    // )
    //         )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            databaseReference.push().set("Prashul Shrestha");
          },
        ),);
  }

  Widget buildList() {
   
     
    return Column(children: <Widget>[
      data != null ? 
      Text('Calories: ${data.values}'): Text('Sorry! Blank'),
    ],);
  }
}
