import 'package:incubate_app/models/food.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FoodRecommendation {
  List<FoodModel>? breakfast;
  List<FoodModel>? afternoonSnack;
  List<FoodModel>? lunch;
  List<FoodModel>? dinner;
  List<FoodModel>? morningSnack;

  FoodRecommendation({
    this.morningSnack,
    this.breakfast,
    this.afternoonSnack,
    this.lunch,
    this.dinner,
  });

  FoodRecommendation.fromJson(Map<String, dynamic> json)
      : breakfast = List<FoodModel>.from(json['BREAKFAST'] != null
            ? json['BREAKFAST'].map((e) => FoodModel.fromJson(e))
            : []),
        morningSnack = List<FoodModel>.from(json['MORNING_SNACK'] != null
            ? json['MORNING_SNACK'].map((e) => FoodModel.fromJson(e))
            : []),
        afternoonSnack = List<FoodModel>.from(json['AFTERNOON_SNACK'] != null
            ? json['AFTERNOON_SNACK'].map((e) => FoodModel.fromJson(e))
            : []),
        lunch = List<FoodModel>.from(json['LUNCH'] != null
            ? json['LUNCH'].map((e) => FoodModel.fromJson(e))
            : []),
        dinner = List<FoodModel>.from(json['DINNER'] != null
            ? json['DINNER'].map((e) => FoodModel.fromJson(e))
            : []);

  @override
  String toString() {
    return 'FoodRecommendation{\nbreakfast: ${breakfast?.length}, \nmorning_snack: ${morningSnack?.length}, \nafternoon_snack: ${afternoonSnack?.length}, \nlunch: ${lunch?.length}, \ndinner: ${dinner?.length}\n}';
  }
}
