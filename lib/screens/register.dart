// Create a login page

import 'package:incubate_app/screens/auth.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:incubate_app/screens/user_data_input.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter/material.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/components/text_input.dart';
import 'package:incubate_app/components/flash_message.dart';
import 'package:incubate_app/utils/utils.dart';
import 'package:incubate_app/presentation/custom_icons_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _credFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  Gender? _genderVal;

  void _registerUser() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (!_credFormKey.currentState!.validate()) {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Enter your information', Status.error));
      return;
    }

    if (_genderVal == null) {
      scaffoldMessenger
          .showSnackBar(FlashMessage().get('Select your gender', Status.error));
      return;
    }

    // Create new user body to send to API
    var body = <String, dynamic>{
      // "username": "test_username",
      "email": _emailController.text,
      "emailVisibility": true,
      "password": _passController.text,
      "passwordConfirm": _passController.text,
      "name": _nameController.text,
      // "address": "test_address",
      "age": _ageController.text,
      "height_cm": _heightController.text,
      "weight_kg": _weightController.text,
      "gender": Utils.convertEnumToUpper(_genderVal),
      "allergens": [],
      "primary_diet": "ANYTHING",
      "goal": "MUSCLE_GAIN",
      "meal_per_day": 3,
      "activity_level": "SEDENTARY",
      "setup_done": false
    };

    navigator.push(MaterialPageRoute(
        builder: (context) => UserDataInputScreen(
              prevBody: body,
            ),
        maintainState: false));
    // (optional) send an email verification request
    // await pb.collection('users').requestVerification(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          // title: const Text(
          //   'REGISTER',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 12,
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w800,
          //   ),
          // ),
          scrolledUnderElevation: 0.0,
          titleSpacing: 9,
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
                            height: 100,
                          ),
                          Row(
                            children: [
                              Text(
                                'Create your',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
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
                                'Please enter your details below',
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
                          height: 30,
                        ),
                        /** Email Text Input */
                        TextInput(
                          controller: _emailController,
                          hintText: 'Email',
                          obscureText: false,
                          prefixIconType: Icons.email,
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        /** Password Text Input */
                        TextInput(
                          controller: _passController,
                          hintText: 'Password',
                          obscureText: true,
                          prefixIconType: Icons.lock,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /** Name Text Input */
                        TextInput(
                          controller: _nameController,
                          hintText: 'Name',
                          obscureText: false,
                          prefixIconType: Icons.person,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /** Age Text Input */
                        TextInput(
                          controller: _ageController,
                          hintText: 'Age',
                          obscureText: false,
                          prefixIconType: Icons.numbers,
                          isNumber: true,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /** Weight Text Input */
                        TextInput(
                          controller: _weightController,
                          hintText: 'Weight',
                          obscureText: false,
                          prefixIconType: CustomIcons.weight_hanging,
                          isNumber: true,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /** Height Text Input */
                        TextInput(
                          controller: _heightController,
                          hintText: 'Height',
                          obscureText: false,
                          prefixIconType: Icons.height_outlined,
                          isNumber: true,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        /** Gender Text Input */

                        // TextInput(
                        //   controller: _genderController,
                        //   hintText: 'Gender',
                        //   obscureText: false,
                        //   prefixIconType: Icons.man_3_outlined,
                        // ),
                        /** Gender option chips */
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
                              ' your gender',
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
                        Wrap(spacing: 5, children: [
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            checkmarkColor: _genderVal == Gender.male
                                ? Colors.white
                                : Colors.black,
                            labelStyle: TextStyle(
                              color: _genderVal == Gender.male
                                  ? Colors.white
                                  : Theme.of(context).highlightColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            selectedColor: Theme.of(context).highlightColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            label: Text('Male'),
                            selected: _genderVal == Gender.male,
                            onSelected: (bool selected) {
                              setState(() {
                                _genderVal = selected ? Gender.male : null;
                              });
                            },
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).highlightColor),
                            ),
                            checkmarkColor: _genderVal == Gender.female
                                ? Colors.white
                                : Colors.black,
                            labelStyle: TextStyle(
                              color: _genderVal == Gender.female
                                  ? Colors.white
                                  : Theme.of(context).highlightColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            selectedColor: Theme.of(context).highlightColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            label: Text('Female'),
                            selected: _genderVal == Gender.female,
                            onSelected: (bool selected) {
                              setState(() {
                                _genderVal = selected ? Gender.female : null;
                              });
                            },
                          )
                        ]),

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
                          height: 0,
                        ),
                        /* Login button */
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRect(
                                child: SizedBox(
                                  width: 120,
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
                                        'Next',
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
