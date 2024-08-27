import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:incubate_app/models/food.model.dart';
import 'package:incubate_app/components/food_card.dart';
import 'package:incubate_app/models/food_recommendations.model.dart';

class HorizontalFoodList extends StatelessWidget {
  final FoodRecommendation? foods; // Replace 'FoodModel' with your actual model
  final userId;

  const HorizontalFoodList({required this.foods, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (foods == null) {
        return Container();
      }

      return Column(
        children: [
          Builder(builder: (context) {
            if (foods?.breakfast == null) {
              return Container();
            }
            if (foods?.breakfast?.isEmpty ?? true) {
              return Container();
            }
            return _buildListViewWithTitle("Breakfast", foods?.breakfast);
          }),
          Builder(builder: (context) {
            if (foods?.morningSnack == null) {
              return Container();
            }
            if (foods?.morningSnack?.isEmpty ?? true) {
              return Container();
            }
            return _buildListViewWithTitle(
                "Morning Snack", foods?.morningSnack);
          }),
          Builder(builder: (context) {
            if (foods?.lunch == null) {
              return Container();
            }
            if (foods?.lunch?.isEmpty ?? true) {
              return Container();
            }
            return _buildListViewWithTitle("Lunch", foods?.lunch);
          }),
          Builder(builder: (context) {
            if (foods?.afternoonSnack == null) {
              return Container();
            }
            if (foods?.afternoonSnack?.isEmpty ?? true) {
              return Container();
            }
            return _buildListViewWithTitle(
                "Afternoon Snack", foods?.afternoonSnack);
          }),
          Builder(builder: (context) {
            if (foods?.dinner == null) {
              return Container();
            }
            if (foods?.dinner?.isEmpty ?? true) {
              return Container();
            }
            return _buildListViewWithTitle("Dinner", foods?.dinner);
          }),
          // _buildListViewWithTitle("Morning Snack", foods?.morningSnack),
          // _buildListViewWithTitle("Lunch", foods?.lunch),
          // _buildListViewWithTitle("Afternoon Snack", foods?.afternoonSnack),
          // _buildListViewWithTitle("Dinner", foods?.dinner),
        ],
      );
    });
  }

  Widget _buildListViewWithTitle(String title, List<FoodModel>? foodList) {
    if (foodList == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: const Color(0xffE15555),
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 200.0, // Adjust the height according to your design
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return FoodCard(
                    food: foodList.elementAt(index), userId: userId);
              },
            ),
          ),
        ),
      ],
    );
  }
}
