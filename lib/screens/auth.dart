// Create a login page

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incubate_app/components/flash_message.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/components/text_input.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:incubate_app/screens/dashboard.dart';
import 'package:incubate_app/screens/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Create key
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _apiClient = ApiClient();
  late final bool _isAuth;

  void _authUser() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (!_formKey.currentState!.validate()) {
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Enter your credentials', Status.error));
      return;
    }

    // Clear authStore
    pb.authStore.clear();
    final res =
        await _apiClient.authLogin(_emailController.text, _passController.text);

    if (res) {
      // print(pb.authStore.model.id);
      navigator.pop();
      navigator.push(MaterialPageRoute(
          builder: (context) =>
              DashboardScreen(userId: pb.authStore.model.id)));
    } else {
      print("Error logging in!");
      scaffoldMessenger.showSnackBar(
          FlashMessage().get('Invalid credentials', Status.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).highlightColor,
        body: Builder(builder: (context) {
          return Form(
              key: _formKey,
              // painter: RPSCustomPainter(),
              child: Center(
                  child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset(
                                //   "assets/images/logo.png",
                                //   width: 200,
                                //   height: 200,
                                // ),
                              ])),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Enter your login details',
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text(
                                  'Welcome to',
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 25,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  ' mAIMeal!',
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 25,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
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
                              height: 10,
                            ),
                            /* Login button */
                            Align(
                              child: Wrap(children: [
                                ClipRect(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          _authUser();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).highlightColor,
                                        ),
                                        child: const Row(children: [
                                          Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        ])),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: [
                                      const Text(
                                        "Don't have an account?",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 147, 126, 126),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterScreen()));
                                        },
                                        child: Text(
                                          'Create an account',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )));
        }));
  }
}
