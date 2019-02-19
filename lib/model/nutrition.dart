
class Nutrition{
  String Caffiene;
  String Calories;
  String Carbohydrates;
  String Cholesterol;
  String Description;
  String Fat;
  String Potassium;
  String Protein;
  String Sodium;

  
   Nutrition ({this.Caffiene , this.Calories, this.Carbohydrates , this.Cholesterol , this.Description,this.Fat ,this.Potassium, this.Protein,this.Sodium});

  factory Nutrition.fromJson(Map<String, dynamic> value)
  {
    return new Nutrition(
    Caffiene: value['Caffiene'],
    Calories: value['Calories'],
    Carbohydrates: value['Carbohydrates'],
    Cholesterol:value['Cholesterol'],
    Description : value['Description'],
    Fat: value['Description'],
    Potassium: value['Potassium'],
    Protein: value['Protein'],
    Sodium: value['Sodium']);

  }



}