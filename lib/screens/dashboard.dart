import 'package:flutter/material.dart';
import 'package:incubate_app/components/horizontal_food_list.dart';
import 'package:incubate_app/models/food.model.dart';
import 'package:incubate_app/models/food_recommendations.model.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/screens/user_profile.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:incubate_app/components/top_card.dart';
import 'package:incubate_app/components/custom_drawer.dart';
import 'package:incubate_app/screens/food_details.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:incubate_app/presentation/custom_icons_icons.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  const DashboardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // UserModel? _curUser;
  int? _goalsDiffKg;
  FoodModel? _foodClicked;
  final _foodIdClicked = 'zmdsdjrwn53rv7a';
  int _navbarIdx = 0;
  List<Widget> routes = [];

  Future<UserModel>? _curUser;
  Future<FoodRecommendation>? _foodRecommendationList;

  /** Get user details */
  void _getUser() async {
    var user = ApiClient().getUserDetails(widget.userId);

    setState(() {
      _curUser = user;
    });
  }

  void _getFood() async {
    var food = await ApiClient().getFoodById('zmdsdjrwn53rv7a');
    _foodClicked = food;
  }

  void _getFoodRecommendations() async {
    var foods = ApiClient().getFoodRecommendations(widget.userId);
    setState(() {
      _foodRecommendationList = foods;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _getFoodRecommendations();
    routes.add(UserProfile(
      userId: widget.userId,
    ));
    routes.add(UserProfile(
      userId: widget.userId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getUser();
        _getFoodRecommendations();
      },
      color: Theme.of(context).highlightColor,
      child: FutureBuilder(
        future: _curUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).highlightColor,
            ));
          } else {
            if (snapshot.data?.goal == Goal.weight_loss) {
              _goalsDiffKg = -15;
            } else if (snapshot.data?.goal == Goal.muscle_gain) {
              _goalsDiffKg = 15;
            } else {
              _goalsDiffKg = 0;
            }
            snapshot.data?.id = widget.userId;
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              drawer: Drawer(
                child: Center(
                    child: CustomDrawer(
                  email: snapshot.data?.email ?? "Email",
                  name: snapshot.data?.name ?? "Name",
                  profilePictureUrl: snapshot.data?.avatar,
                  userId: snapshot.data?.id,
                )),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                actions: <Widget>[
                  // IconButton(
                  //   icon: const Icon(Icons.notifications),
                  //   onPressed: () {},
                  // ),
                  GestureDetector(
                    onTap: () {
                      if (snapshot.data == null) return;
                      final navigator = Navigator.of(context);

                      navigator
                          .push(MaterialPageRoute(
                              builder: (context) => UserProfile(
                                    userId: widget.userId,
                                  ),
                              maintainState: false))
                          .whenComplete(() {
                        setState(() {
                          _getUser();
                          _getFoodRecommendations();
                        });
                      });
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 15, top: 10),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snapshot.data?.avatar ==
                                    "" ||
                                snapshot.data?.avatar == null
                            ? ApiClient.getFileUrl(
                                'users',
                                snapshot.data?.id ?? '',
                                snapshot.data?.avatar ?? '')
                            : "http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/1pn13waid8unff3/male_placeholder_lqibmv7_kt2_pwyxqMIrn7.jpg?token="),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],

                // elevation: 10,
                scrolledUnderElevation: 0.0,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).highlightColor,
              ),
              body: CustomPaint(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      Text(
                                        'Hello, ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        Utils.getFirstName(
                                            snapshot.data?.name ?? 'User'),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'How are you doing and feeling today?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Your Stats',
                              style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TopCard(
                      kcalPerDay: snapshot.data?.kcalPerDay ?? 0,
                      bmi: snapshot.data?.bmi ?? 0,
                      bb: snapshot.data?.weightKg ?? 0,
                      goalsDiff: _goalsDiffKg ?? 0,
                    ),
                    // Create a button
                    // ElevatedButton(
                    //     onPressed: () {
                    //       _getFood();
                    //       print(_foodIdClicked);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => FoodDetailsScreen(
                    //                   curFoodId: _foodIdClicked)));
                    //     },
                    //     child: Text('Food')),
                    SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                        future: _foodRecommendationList,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                ),
                                Center(
                                    child: CircularProgressIndicator(
                                  color: Theme.of(context).highlightColor,
                                )),
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: HorizontalFoodList(
                                  foods: snapshot.data, userId: widget.userId),
                            );
                          }
                        }),
                    // HorizontalFoodList(foods: foods)
                  ],
                )),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  child: GNav(
                    backgroundColor: Theme.of(context).highlightColor,
                    gap: 5,
                    // currentIndex: _navbarIdx,
                    activeColor: Theme.of(context).highlightColor,
                    color: Theme.of(context).primaryColor,
                    tabBackgroundColor: Theme.of(context).primaryColor,
                    onTabChange: (index) {
                      print(index);
                      setState(() {
                        _navbarIdx = index;
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.rss_feed,
                        text: 'Feed',
                      ),
                      GButton(
                        icon: Icons.shopping_cart,
                        text: 'Cart',
                      ),
                      GButton(
                        icon: CustomIcons.food,
                        text: 'History',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
