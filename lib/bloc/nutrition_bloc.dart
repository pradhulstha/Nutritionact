import 'package:rxdart/rxdart.dart';
import 'package:nutritionacts/model/nutrition.dart';
import 'package:nutritionacts/repository/nutrition_api.dart';

class NutritionBloc{
  final _repository = NutritionAPI();
  final _nutritionFetcher = PublishSubject<Nutrition>();

  Observable<Nutrition> get allNutritionFacts => _nutritionFetcher.stream;

  fetchNutrition(String label) async{
    Nutrition nutrition = await _repository.getFacts(label);
    _nutritionFetcher.sink.add(nutrition);
  }
    dispose() {
    _nutritionFetcher.close();
  }
}


final nutritionbloc = NutritionBloc();