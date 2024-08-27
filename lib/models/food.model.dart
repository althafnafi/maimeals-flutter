// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pocketbase/pocketbase.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

enum CookingMethod {
  boil,
  bake,
  roast,
  fry,
  grill,
  steam,
  saute,
  simmer,
  stir_fry,
  poach
}

enum DietType { anything, vegetarian, keto, vegan, paleo, mediterranean }

enum Taste {
  sweet,
  sour,
  salty,
  bitter,
  spicy,
  savory,
  umami,
  tangy,
  mild,
  tart,
  plain
}

enum MealTime { breakfast, lunch, dinner, snack, anytime }

enum Ingredient {
  sugar,
  salt,
  vanilla,
  yogurt,
  juice,
  lemon,
  milk,
  chili,
  pepper,
  onions,
  garlic,
  clove,
  tofu,
  eggplant,
  fruit,
  vegetable,
  tomato,
  mushrooms,
  cabbage,
  celery,
  chicken,
  butter,
  flour,
  egg,
  margarine,
  baking_powder,
  honey,
  coffee,
  nut,
  chocolate,
  coconut,
  water,
  meat,
  rice,
  bread,
  noodle,
  poultry
}

enum Tag {
  rice,
  bread,
  pasta,
  noodle,
  oatmeals,
  chicken,
  meat,
  fish,
  seafood,
  vegetable,
  dessert,
  poultry,
  beans,
  fruit,
  nuts,
  cheese,
  milk,
  coconut,
  beverages,
  egg,
  flour
}

enum Allergen {
  moluscs,
  eggs,
  fish,
  lupin,
  soya,
  milk,
  peanuts,
  gluten,
  crustaceans,
  mustard,
  nuts,
  sesame,
  celery,
  sulphites
}

@JsonSerializable()
class FoodModel {
  String id;
  String name;
  String? description;
  String? image;
  String? nutrition;
  List<CookingMethod?> cookingMethods;
  List<DietType?> dietTypes;
  List<Taste?> taste;
  List<MealTime?> mealTimes;
  List<Ingredient?> ingredients;
  List<Tag?> tags;
  List<Allergen?> allergens;
  double? priceRp;
  double caloriesKcal;
  double weightGr;
  String? ingredientsText;

  FoodModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.nutrition,
    required this.cookingMethods,
    required this.dietTypes,
    required this.taste,
    required this.mealTimes,
    required this.ingredients,
    required this.tags,
    required this.allergens,
    this.priceRp,
    required this.caloriesKcal,
    required this.weightGr,
    this.ingredientsText,
  });

  factory FoodModel.fromRecord(RecordModel record) {
    return FoodModel(
      id: record.id,
      name: record.getDataValue<String>('food_name'),
      description: record.getDataValue<String>('description'),
      image: record.getDataValue<String>('image'),
      nutrition: record.getDataValue<String>('nutrition'),
      cookingMethods: Utils.convertStringsToEnums(
        CookingMethod.values,
        record.getDataValue<List<String>>('cooking_methods'),
      ),
      dietTypes: Utils.convertStringsToEnums(
        DietType.values,
        record.getDataValue<List<String>>('diet_type'),
      ),
      taste: Utils.convertStringsToEnums(
        Taste.values,
        record.getDataValue<List<String>>('taste'),
      ),
      mealTimes: Utils.convertStringsToEnums(
        MealTime.values,
        record.getDataValue<List<String>>('meal_times'),
      ),
      ingredients: Utils.convertStringsToEnums(
        Ingredient.values,
        record.getDataValue<List<String>>('ingredients'),
      ),
      tags: Utils.convertStringsToEnums(
        Tag.values,
        record.getDataValue<List<String>>('tags'),
      ),
      allergens: Utils.convertStringsToEnums(
        Allergen.values,
        record.getDataValue<List<String>>('allergens'),
      ),
      priceRp: record.getDataValue<double>('price_rp'),
      caloriesKcal: record.getDataValue<double>('calories_kcal'),
      weightGr: record.getDataValue<double>('weight_gr'),
      ingredientsText: record.getDataValue<String>('ingredients_text'),
    );
  }

  FoodModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['food_name'],
        description = json['description'],
        image = json['image'],
        nutrition = json['nutrition'],
        cookingMethods = Utils.convertStringsToEnums(
          CookingMethod.values,
          json['cooking_methods'],
        ),
        dietTypes = Utils.convertStringsToEnums(
          DietType.values,
          json['diet_type'],
        ),
        taste = Utils.convertStringsToEnums(
          Taste.values,
          json['taste'],
        ),
        mealTimes = Utils.convertStringsToEnums(
          MealTime.values,
          json['meal_times'],
        ),
        ingredients = Utils.convertStringsToEnums(
          Ingredient.values,
          json['ingredients'],
        ),
        tags = Utils.convertStringsToEnums(
          Tag.values,
          json['tags'],
        ),
        allergens = Utils.convertStringsToEnums(
          Allergen.values,
          json['allergens'],
        ),
        priceRp = json['price_rp'] + 0.0,
        caloriesKcal = json['calories_kcal'] + 0.0,
        weightGr = json['weight_gr'] + 0.0,
        ingredientsText = json['ingredients_text'];

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, description: $description, image: $image, nutrition: $nutrition, cookingMethod: $cookingMethods, dietType: $dietTypes, taste: $taste, mealTimes: $mealTimes, ingredients: $ingredients, tags: $tags, allergens: $allergens, priceRp: $priceRp, caloriesKcal: $caloriesKcal, weightGr: $weightGr)';
  }
}
