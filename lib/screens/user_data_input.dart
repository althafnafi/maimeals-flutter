// Create a login page

import 'package:incubate_app/presentation/custom_icons_icons.dart';
import 'package:incubate_app/screens/auth.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter/material.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/components/text_input.dart';
import 'package:incubate_app/components/flash_message.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final pb = PocketBase('https://inc-app.pockethost.io');

class UserDataInputScreen extends StatefulWidget {
  final Map<String, dynamic> prevBody;

  const UserDataInputScreen({Key? key, required this.prevBody})
      : super(key: key);

  @override
  State<UserDataInputScreen> createState() => _UserDataInputScreenState();
}

class AllergenItems {
  final int id;
  final String name;
  final Allergen allergen;

  AllergenItems({required this.id, required this.name, required this.allergen});
}

class _UserDataInputScreenState extends State<UserDataInputScreen> {
  static final List<AllergenItems> _allergens = [
    AllergenItems(id: 1, name: "Moluscs", allergen: Allergen.moluscs),
    AllergenItems(id: 2, name: "Eggs", allergen: Allergen.eggs),
    AllergenItems(id: 3, name: "Fish", allergen: Allergen.fish),
    AllergenItems(id: 4, name: "Lupin", allergen: Allergen.lupin),
    AllergenItems(id: 5, name: "Soya", allergen: Allergen.soya),
    AllergenItems(id: 6, name: "Milk", allergen: Allergen.milk),
    AllergenItems(id: 7, name: "Peanuts", allergen: Allergen.peanuts),
    AllergenItems(id: 8, name: "Gluten", allergen: Allergen.gluten),
    AllergenItems(id: 9, name: "Crustaceans", allergen: Allergen.crustaceans),
    AllergenItems(id: 10, name: "Mustard", allergen: Allergen.mustard),
    AllergenItems(id: 11, name: "Nuts", allergen: Allergen.nuts),
    AllergenItems(id: 12, name: "Sesame", allergen: Allergen.sesame),
    AllergenItems(id: 13, name: "Celery", allergen: Allergen.celery),
    AllergenItems(id: 14, name: "Sulphies", allergen: Allergen.sulphies),
  ];
  final _allergenItems = _allergens.map((allergen) {
    return MultiSelectItem<AllergenItems>(allergen, allergen.name);
  }).toList();

  List<AllergenItems> _selectedAllergens = [];

  final _allergenMultiSelectKey = GlobalKey<FormFieldState>();
  final _credFormKey = GlobalKey<FormState>();

  final TextEditingController _mealCountController = TextEditingController();

  Goal? _goalVal;
  PrimaryDiet? _primaryDietVal;
  List<Allergen>? _allergensVal;
  ActivityLevel? _activityLevelVal;

  void _registerUser() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Create new user body to send to API
    var newBody = widget.prevBody;

    List<String> allergens = Utils.convertEnumsToDBStrings(_allergensVal);
    // if (_allergensVal != null) {
    //   for (var allergen in _allergensVal!) {
    //     allergens.add(Utils.convertEnumToUpper(allergen));
    //   }
    // }

    for (AllergenItems a in _selectedAllergens) {
      allergens.add(Utils.convertEnumToUpper(a.allergen));
    }

    /** V A L I D A T I O N */

    if (_goalVal == null ||
        _primaryDietVal == null ||
        _activityLevelVal == null) {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Select one of the options', Status.error));
      return;
    }

    if (!_credFormKey.currentState!.validate()) {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Fill the requested data', Status.error));
      return;
    }

    newBody['meal_per_day'] = _mealCountController.text;
    newBody['goal'] = Utils.convertEnumToUpper(_goalVal);
    newBody['primary_diet'] = Utils.convertEnumToUpper(_primaryDietVal);
    newBody['activity_level'] = Utils.convertEnumToUpper(_activityLevelVal);
    newBody['allergens'] = allergens;

    final res = await ApiClient().registerUser(newBody);

    if (res) {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('User registered successfully', Status.success));
      navigator.push(MaterialPageRoute(
          builder: (context) => const AuthScreen(), maintainState: false));
    } else {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Error while authenticating', Status.error));
    }

    // (optional) send an email verification request
    // await pb.collection('users').requestVerification(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).highlightColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Form(
            key: _credFormKey,
            // painter: RPSCustomPainter(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Goals and Meal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Preferences',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Please enter your goals and preferences',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          children: [
                            Text(
                              'How many times',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' do you eat in a day?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /** Email Text Input */
                        TextInput(
                          controller: _mealCountController,
                          hintText: 'Meals per Day',
                          obscureText: false,
                          prefixIconType: CustomIcons.food_1,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          children: [
                            Text(
                              'How active ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'are you?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  children: [
                                    ChoiceChip(
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Text('1',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      checkmarkColor: _activityLevelVal ==
                                              ActivityLevel.sedentary
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _activityLevelVal ==
                                                ActivityLevel.sedentary
                                            ? Colors.white
                                            : Colors.red[600],
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor: Colors.red[600],
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Sedentary'),
                                      selected: _activityLevelVal ==
                                          ActivityLevel.sedentary,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _activityLevelVal = selected
                                              ? ActivityLevel.sedentary
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        child: Text('2',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.orange),
                                      ),
                                      checkmarkColor: _activityLevelVal ==
                                              ActivityLevel.lightly_active
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _activityLevelVal ==
                                                ActivityLevel.lightly_active
                                            ? Colors.white
                                            : Colors.orange[700],
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor: Colors.orange[700],
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Lightly Active'),
                                      selected: _activityLevelVal ==
                                          ActivityLevel.lightly_active,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _activityLevelVal = selected
                                              ? ActivityLevel.lightly_active
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      avatar: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).highlightColor,
                                        child: Text('3',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor: _activityLevelVal ==
                                              ActivityLevel.moderately_active
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _activityLevelVal ==
                                                ActivityLevel.moderately_active
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Moderately Active'),
                                      selected: _activityLevelVal ==
                                          ActivityLevel.moderately_active,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _activityLevelVal = selected
                                              ? ActivityLevel.moderately_active
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text('4',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      checkmarkColor: _activityLevelVal ==
                                              ActivityLevel.very_active
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _activityLevelVal ==
                                                ActivityLevel.very_active
                                            ? Colors.white
                                            : Colors.blue[500],
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor: Colors.blue[500],
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Very Active'),
                                      selected: _activityLevelVal ==
                                          ActivityLevel.very_active,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _activityLevelVal = selected
                                              ? ActivityLevel.very_active
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Text('5',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.green),
                                      ),
                                      checkmarkColor: _activityLevelVal ==
                                              ActivityLevel.extremely_active
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _activityLevelVal ==
                                                ActivityLevel.extremely_active
                                            ? Colors.white
                                            : Colors.green[500],
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor: Colors.green[500],
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Extremely Active'),
                                      selected: _activityLevelVal ==
                                          ActivityLevel.extremely_active,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _activityLevelVal = selected
                                              ? ActivityLevel.extremely_active
                                              : null;
                                        });
                                      },
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        /** Goals option chips */
                        const Row(
                          children: [
                            Text(
                              'Select',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' your goals',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  children: [
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _goalVal == Goal.muscle_gain
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _goalVal == Goal.muscle_gain
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Muscle Gain'),
                                      selected: _goalVal == Goal.muscle_gain,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _goalVal = selected
                                              ? Goal.muscle_gain
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _goalVal == Goal.balanced_diet
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _goalVal == Goal.balanced_diet
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Balanced Diet'),
                                      selected: _goalVal == Goal.balanced_diet,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _goalVal = selected
                                              ? Goal.balanced_diet
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _goalVal == Goal.weight_loss
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _goalVal == Goal.weight_loss
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Weight Loss'),
                                      selected: _goalVal == Goal.weight_loss,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _goalVal = selected
                                              ? Goal.weight_loss
                                              : null;
                                        });
                                      },
                                    )
                                  ]),
                            ),
                          ],
                        ),

                        // const Text(
                        //   'Forgot Password?',
                        //   style: TextStyle(
                        //     color: Color(0xFF755DC1),
                        //     fontSize: 13,
                        //     fontFamily: 'Poppins',
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Select',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' your primary diet type',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  children: [
                                    ChoiceChip(
                                      // avatar: const CircleAvatar(
                                      //   backgroundImage: AssetImage(
                                      //       'assets/images/logo.png'),
                                      // ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor: _primaryDietVal ==
                                              PrimaryDiet.anything
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.anything
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Anything'),
                                      selected: _primaryDietVal ==
                                          PrimaryDiet.anything,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.anything
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor: _primaryDietVal ==
                                              PrimaryDiet.vegetarian
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.vegetarian
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Vegetarian'),
                                      selected: _primaryDietVal ==
                                          PrimaryDiet.vegetarian,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.vegetarian
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _primaryDietVal == PrimaryDiet.keto
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.keto
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Keto'),
                                      selected:
                                          _primaryDietVal == PrimaryDiet.keto,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.keto
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _primaryDietVal == PrimaryDiet.vegan
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.vegan
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Vegan'),
                                      selected:
                                          _primaryDietVal == PrimaryDiet.vegan,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.vegan
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor:
                                          _primaryDietVal == PrimaryDiet.paleo
                                              ? Colors.white
                                              : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.paleo
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Paleo'),
                                      selected:
                                          _primaryDietVal == PrimaryDiet.paleo,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.paleo
                                              : null;
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .highlightColor),
                                      ),
                                      checkmarkColor: _primaryDietVal ==
                                              PrimaryDiet.mediterranean
                                          ? Colors.white
                                          : Colors.black,
                                      labelStyle: TextStyle(
                                        color: _primaryDietVal ==
                                                PrimaryDiet.mediterranean
                                            ? Colors.white
                                            : Theme.of(context).highlightColor,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedColor:
                                          Theme.of(context).highlightColor,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      label: Text('Mediterranean'),
                                      selected: _primaryDietVal ==
                                          PrimaryDiet.mediterranean,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _primaryDietVal = selected
                                              ? PrimaryDiet.mediterranean
                                              : null;
                                        });
                                      },
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Which kinds',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' of food are you allergic to?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MultiSelectDialogField(
                          searchable: true,
                          items: _allergenItems,
                          title: Text("Allergens",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              )),
                          selectedColor: Theme.of(context).highlightColor,
                          barrierColor: Colors.black.withOpacity(0.7),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Theme.of(context).highlightColor,
                              width: 1.5,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            color: Theme.of(context).highlightColor,
                          ),
                          buttonText: Text(
                            " Select Here",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Theme.of(context).highlightColor,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            _selectedAllergens = results;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        /* Login button */
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRect(
                                child: SizedBox(
                                  width: 145,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _registerUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .highlightColor // background
                                        ),
                                    child: const Row(children: [
                                      Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_right_alt_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
