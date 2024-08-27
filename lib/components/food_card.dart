import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/models/food.model.dart';
import 'package:incubate_app/screens/food_details.dart';

class FoodCard extends StatelessWidget {
  final FoodModel? food; // Replace 'FoodModel' with your actual model
  final String? userId;

  const FoodCard({this.food, this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetailsScreen(
                      curFoodId: this.food?.id ?? '',
                      userId: this.userId ?? '',
                    )));
      },
      child: Container(
        width: 150.0, // Adjust the width according to your design
        margin:
            EdgeInsets.symmetric(horizontal: 8.0), // Add margin between cards
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0, // Adjust the height of the image square
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(this.food?.image == '' ||
                            this.food?.image == null
                        ? 'http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/rkzi8oat3ot5ezd/untitled_bVDNeXS8mU.png?token='
                        : ApiClient.getFileUrl(
                            'foods', food?.id ?? '', food?.image ?? '')),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(children: [
                      Text(
                        food?.name ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ]),
                    SizedBox(height: 4.0),
                    Text(
                        '${food?.caloriesKcal.toStringAsFixed(2) ?? '-'} Calories'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
