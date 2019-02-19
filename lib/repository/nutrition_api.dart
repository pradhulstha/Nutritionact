import 'package:nutritionacts/model/nutrition.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;


class NutritionAPI{

  Future<Nutrition> getFacts(String label) async{

    print("In API: ");
    label = "Coke";
    var snapData;
    database.reference().child(label).once().then((DataSnapshot snapshot){

       print(snapshot.value);
      snapData = snapshot.value;
    });
    return Nutrition.fromJson(snapData);
  }

}