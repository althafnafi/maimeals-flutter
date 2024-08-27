import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:incubate_app/components/order_popup.dart';
import 'package:incubate_app/models/food.model.dart';
import 'package:incubate_app/core/api_client.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String curFoodId;
  final String userId;

  const FoodDetailsScreen({
    required this.curFoodId,
    required this.userId,
  });

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;
  // FoodModel? _curFood;
  Future<FoodModel>? _curFoodFuture;

  void _getFood() async {
    // var food = await ApiClient().getFoodById(widget.curFoodId);
    var foodFuture = ApiClient().getFoodById(widget.curFoodId);
    print(foodFuture);
    setState(() {
      // _curFood = food;
      _curFoodFuture = foodFuture;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFood();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _curFoodFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).highlightColor,
            ));
          } else {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                centerTitle: true,
                title: Text(snapshot.data?.name ?? "Food name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    )),
                backgroundColor: Theme.of(context).highlightColor,
                actions: <Widget>[
                  // IconButton(
                  //   icon: const Icon(Icons.notifications),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(children: [
                            Image.network(
                              snapshot.data?.image == null ||
                                      snapshot.data?.image == ""
                                  ? "http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/rkzi8oat3ot5ezd/untitled_bVDNeXS8mU.png?token="
                                  : ApiClient.getFileUrl(
                                      'foods',
                                      snapshot.data?.id ?? '',
                                      snapshot.data?.image ?? ''),
                              height: 200.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Align(
                                    //         child: Text(
                                    //           snapshot.data?.name ?? "Food name",
                                    //           style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 18,
                                    //             fontFamily: 'Montserrat',
                                    //             fontWeight: FontWeight.w500,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 15,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.0),
                                Text(
                                  snapshot.data?.name ?? "Food name",
                                  style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.0),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text('Calories: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          '${snapshot.data?.caloriesKcal == null ? 0 : (snapshot.data!.caloriesKcal * 1000).toStringAsFixed(1)} cal'),
                                      const SizedBox(width: 15.0),
                                      Text('Weight: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          '${snapshot.data?.weightGr == null ? 0 : (snapshot.data!.weightGr).toStringAsFixed(0)} gram(s)'),
                                      const SizedBox(width: 15.0),
                                      Text('Ratings: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text('${4.0}'),
                                      Icon(Icons.star,
                                          color: Colors
                                              .yellow[700]), // TODO: Add rating
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text('Description',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5.0),
                                Text((snapshot.data?.description == null ||
                                        snapshot.data?.description == "")
                                    ? "-"
                                    : snapshot.data!.description!),
                                SizedBox(height: 10.0),
                                // _buildChipSection(
                                //     "Tags",
                                //     (snapshot.data?.tags == null
                                //             ? []
                                //             : snapshot.data!.tags)
                                //         .map((tag) =>
                                //             EnumToString.convertToString(tag,
                                //                 camelCase: true))
                                //         .toList()),
                                _buildChipSection(
                                    "Contains",
                                    (snapshot.data?.allergens == null
                                            ? []
                                            : snapshot.data!.allergens)
                                        .map((allergen) =>
                                            EnumToString.convertToString(
                                                allergen,
                                                camelCase: true))
                                        .toList()),
                                _buildChipSection(
                                    "Diet types",
                                    (snapshot.data?.dietTypes == null
                                            ? []
                                            : snapshot.data!.dietTypes)
                                        .map((dietType) =>
                                            EnumToString.convertToString(
                                                dietType,
                                                camelCase: true))
                                        .toList()),
                                _buildChipSection(
                                    "Cooking methods",
                                    (snapshot.data?.cookingMethods == null
                                            ? []
                                            : snapshot.data!.cookingMethods)
                                        .map((cookingMethod) =>
                                            EnumToString.convertToString(
                                                cookingMethod,
                                                camelCase: true))
                                        .toList()),
                                SizedBox(height: 16.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 70.0),
                  ],
                ),
              ),
              bottomNavigationBar: _buildQuantityEditor(snapshot.data),
              extendBody: true,
            );
          }
        });
  }

  Widget _buildChipSection(String title, List<String> chips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Divider(
          endIndent: 20.0,
          indent: 0.0,
          color: Colors.black12,
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          runSpacing: 2,
          spacing: 8.0,
          children: chips
              .map((chip) => Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(chip),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  backgroundColor: Theme.of(context).highlightColor,
                  // avatar: CircleAvatar(
                  //   backgroundColor: Colors.red,
                  //   child: Text('1',
                  //       style: TextStyle(
                  //           fontFamily: 'Roboto', color: Colors.black)),
                  // ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.transparent, width: 1))))
              .toList(),
        ),
      ],
    );
  }

  void _orderItem(String user_id, String food_id, {int qty = 1}) async {
    final order = await ApiClient().createOrder(user_id, food_id, qty: qty);

    if (order) {
      showOrderPopup(context);
      return;
    }

    print("Failed to order item");
  }

  Widget _buildQuantityEditor(FoodModel? data) {
    return Row(
      children: [
        // Expanded(
        //     child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     IconButton(
        //       icon: Icon(Icons.remove),
        //       onPressed: () {
        //         if (quantity > 1) {
        //           setState(() {
        //             quantity--;
        //           });
        //         }
        //       },
        //     ),
        //     Text('$quantity'),
        //     IconButton(
        //       icon: Icon(Icons.add),
        //       onPressed: () {
        //         setState(() {
        //           quantity++;
        //         });
        //       },
        //     ),
        //   ],
        // )),
        SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width,
          // width: 330,
          // height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: ElevatedButton(
              onPressed: () {
                print("Order! $quantity ${data?.id}");
                _orderItem(widget.userId, data?.id ?? '', qty: 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
