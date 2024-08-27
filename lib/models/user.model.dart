// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:enum_to_string/enum_to_string.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:incubate_app/utils/utils.dart';

enum Gender { male, female }

enum ActivityLevel {
  sedentary,
  lightly_active,
  moderately_active,
  very_active,
  extremely_active
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
  sulphies,
}

enum PrimaryDiet { anything, vegetarian, keto, vegan, paleo, mediterranean }

enum Goal { weight_loss, balanced_diet, muscle_gain }

enum WeightCategory { underweight, normal, overweight, obese }

class UserModel {
  String id;
  String username;
  String name;
  String email;
  String avatar;
  String? address;
  int heightCm;
  int weightKg;
  Gender gender;
  int age;
  bool setupDone;
  List<Allergen?> allergens;
  ActivityLevel activityLevel;
  Goal goal;
  int mealPerDay;
  int? kcalPerDay;
  double? bmi;
  PrimaryDiet primaryDiet;
  WeightCategory? weightCategory;

  UserModel({
    required this.avatar,
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.address,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
    required this.age,
    required this.setupDone,
    required this.allergens,
    required this.activityLevel,
    required this.goal,
    required this.mealPerDay,
    this.kcalPerDay,
    this.weightCategory,
    this.bmi,
    this.primaryDiet = PrimaryDiet.anything,
  });

  factory UserModel.fromRecord(RecordModel record) {
    return UserModel(
      avatar: record.getDataValue<String>('avatar'),
      id: record.getDataValue<String>('id'),
      username: record.getDataValue<String>('username'),
      name: record.getDataValue<String>('name'),
      email: record.getDataValue<String>('email'),
      address: record.getDataValue<String>('address'),
      heightCm: record.getDataValue<int>('height_cm'),
      weightKg: record.getDataValue<int>('weight_kg'),
      gender: Utils.convertUpperToEnum(
          Gender.values, record.getDataValue<String>('gender')),
      age: record.getDataValue<int>('age'),
      setupDone: record.getDataValue<bool>('setup_done'),
      allergens: Utils.convertStringsToEnums(
          Allergen.values, record.getDataValue<List<String>>('allergens')),
      activityLevel: Utils.convertUpperToEnum(
          ActivityLevel.values, record.getDataValue<String>('activity_level')),
      goal: Utils.convertUpperToEnum(
          Goal.values, record.getDataValue<String>('goal')),
      mealPerDay: record.getDataValue<int>('meal_per_day'),
      kcalPerDay: record.getDataValue<int>('kcal_per_day'),
      bmi: record.getDataValue<double>('bmi'),
      weightCategory: Utils.convertUpperToEnum(WeightCategory.values,
          record.getDataValue<String>('weight_category')),
      primaryDiet: Utils.convertUpperToEnum(
          PrimaryDiet.values, record.getDataValue<String>('primary_diet')),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, name: $name, email: $email, avatar: $avatar, address: $address, heightCm: $heightCm, weightKg: $weightKg, gender: $gender, age: $age, setupDone: $setupDone, allergens: $allergens, activityLevel: $activityLevel, goal: $goal, mealPerDay: $mealPerDay, kcalPerDay: $kcalPerDay, bmi: $bmi, weightCategory: $weightCategory)';
  }
}
