// import pocketbase
import 'dart:convert';

import 'package:incubate_app/models/food_recommendations.model.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:incubate_app/models/food.model.dart';
import 'package:http/http.dart' as http;

const String PB_URL = "http://143.198.194.194:8090";
const String ML_URL = "http://159.223.61.197:3000";
final pb = PocketBase(PB_URL);

class ApiClient {
  Future<bool> updateUser(UserModel user) async {
    try {
      // print(jsonEncode(user));

      final body = <String, dynamic>{
        "name": user.name,
        "address": user.address,
        "age": user.age,
        "height_cm": user.heightCm,
        "weight_kg": user.weightKg,
        "gender": Utils.convertEnumToUpper(user.gender),
        "allergens": Utils.convertEnumsToDBStrings(user.allergens),
        "primary_diet": Utils.convertEnumToUpper(user.primaryDiet),
        "goal": Utils.convertEnumToUpper(user.goal),
        "meal_per_day": user.mealPerDay,
        "activity_level": Utils.convertEnumToUpper(user.activityLevel),
        "setup_done": true
      };
      print(body);
      final record = await pb.collection('users').update(user.id, body: body);
      print(record);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> uploadImage() async {
  //   try {
  //     final record = await pb.collection('users').create(
  //       body: {
  //         'title': 'Hello world!', // some regular text field
  //       },
  //       files: [
  //         http.MultipartFile.fromString(
  //           'avatar',
  //           'example content 1...',
  //           filename: 'file1.txt',
  //         ),
  //       ],
  //     );
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> createOrder(String user_id, String food_id,
      {int qty = 1}) async {
    try {
      final order_items = <String, dynamic>{"qty": qty, "food_id": food_id};
      final order_items_rec =
          await pb.collection('order_items').create(body: order_items);

      final order = <String, dynamic>{
        "status": "IN_CART",
        "user_id": user_id,
        "total": 0,
        "order_item_ids": order_items_rec.id
      };
      final order_rec = await pb.collection('orders').create(body: order);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<FoodRecommendation> getFoodRecommendations(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$ML_URL/recommendations/?user_id=$userId'),
      );
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        // final foodRecommendation = FoodRecommendation.fromJson(data);
        // return foodRecommendation;
        final respMap = jsonDecode(response.body) as Map<String, dynamic>;
        // print(respMap['data']['recommendations']['BREAKFAST'][0]);
        // print(FoodModel.fromJson(
        //     respMap['data']['recommendations']['BREAKFAST'][0]));
        // print(Utils.convertStringsToEnums(MealTime.values,
        //     respMap['data']['recommendations']['BREAKFAST'][0]));
        final res =
            FoodRecommendation.fromJson(respMap['data']['recommendations']);
        // print(respMap['data']['recommendations']['BREAKFAST'][0]);
        print(res);
        return res;
      } else {
        return Future.error(
            Exception('Request error: [${response.statusCode}]]'));
      }
      // final data = jsonDecode(response.body);
      // final foodRecommendation = FoodRecommendation.fromJson(data);
      // return foodRecommendation;
    } catch (err, stack) {
      return Future.error(Exception('Failed to load food recommendations'));
    }
  }

  static String getFileUrl(String collName, String recordId, String fileName) {
    return '$PB_URL/api/files/$collName/$recordId/$fileName';
  }

  Future<bool> authLogin(String email, String pass) async {
    try {
      await pb.collection('users').authWithPassword(
            email,
            pass,
          );
      final fullName = pb.authStore.model.getDataValue<String>('name');
      print("Logged in as '$fullName'");
    } catch (e) {
      print(e);
    }

    return pb.authStore.isValid;
  }

  Future<bool> registerUser(Map<String, dynamic> body) async {
    try {
      final record = await pb.collection('users').create(body: body);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUserDetails(String userId) async {
    try {
      print(userId);
      final record =
          await pb.collection('user_details').getFirstListItem('id= "$userId"');
      final model = UserModel.fromRecord(record);
      if (model.avatar != null || model.avatar != '') {
        if (model.gender == Gender.male) {
          model.avatar =
              "http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/1pn13waid8unff3/male_placeholder_LQibmv7Kt2.jpg?token=";
        } else {
          model.avatar =
              "http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/3vye90dpy2mk1wh/female_placeholder_M2T879mmCv.jpg?token=";
        }
      }

      return model;
    } catch (err) {
      print(err);
      return Future.error(Exception('Failed to load user details'));
    }
  }

  Future<List<FoodModel>> getFoods() async {
    try {
      final records = await pb.collection('foods').getFullList();
      final foods = records.map((record) => FoodModel.fromRecord(record));
      return foods.toList();
    } catch (err) {
      print(err);
      return Future.error(Exception('Failed to load foods'));
    }
  }

  Future<FoodModel> getFoodById(String food_id) async {
    try {
      final record =
          await pb.collection('foods').getFirstListItem('id= "$food_id"');
      final food = FoodModel.fromRecord(record);
      return food;
    } catch (err) {
      print(err);
      return Future.error(Exception('Failed to load food'));
    }
  }

  // Future<List<FoodModel>> getFoodRecommendations(String userId) async {
  //   try {
  //     final records = await pb.collection('foods').getFullList();
  //     final foods = records.map((record) => FoodModel.fromRecord(record));
  //     return foods.toList();
  //   } catch (err) {
  //     print(err);
  //     return Future.error(Exception('Failed to load foods'));
  //   }
  // }
}
