import 'package:flutter/material.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/models/user.model.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  final String userId;

  UserProfile({required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _userProfileKey = GlobalKey<FormState>();

  late Future<UserModel> userFuture;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  bool changesMade = false;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    ageController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    // nameController.addListener(onFieldChanged);
    // emailController.addListener(onFieldChanged);
    // addressController.addListener(onFieldChanged);
    super.initState();
    userFuture = ApiClient().getUserDetails(widget.userId);
  }

  void updateProfilePicture() async {}

  Future<void> onFieldChanged() async {
    if (!changesMade) {
      // setState(() {
      changesMade = true;
      setState(() {/* Some changes are made */});
      // });
    }
  }

  Future<void> onConfirmButtonPressed(UserModel user) async {
    // Perform the save/update logic here
    // You can access the updated values from the text controllers
    // Reset the changesMade flag and update the user object

    if (!_userProfileKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade300,
          content: Text('Error saving changes!'),
        ),
      );
      return;
    }

    user.name = nameController.text;
    user.email = emailController.text;
    user.address = addressController.text;
    user.age = int.parse(ageController.text);
    user.heightCm = int.parse(heightController.text);
    user.weightKg = int.parse(weightController.text);

    final success = await ApiClient().updateUser(user);
    print('success: $success');

    // Show a confirmation message or navigate to the next screen
    // You can customize this part based on your application's needs
    if (!success || success == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade300,
          content: Text('Error saving changes!'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade300,
        content: Text('Changes saved successfully!'),
      ),
    );

    setState(() {
      changesMade = false;
      user.name = nameController.text;
      user.email = emailController.text;
      user.address = addressController.text;
      user.age = int.parse(ageController.text);
      user.heightCm = int.parse(heightController.text);
      user.weightKg = int.parse(weightController.text);

      // Add similar logic for other fields
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Theme.of(context).highlightColor,
      ),
      body: FutureBuilder<UserModel>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).highlightColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          } else {
            UserModel user = snapshot.data!;
            user.id = widget.userId;

            nameController.text = user.name;
            emailController.text = user.email;
            addressController.text = user.address ?? '';
            ageController.text = user.age.toString();
            heightController.text = user.heightCm.toString();
            weightController.text = user.weightKg.toString();

            // nameController.addListener(onFieldChanged);
            // emailController.addListener(onFieldChanged);
            // addressController.addListener(onFieldChanged);

            return Form(
              key: _userProfileKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 5)
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 77,
                                backgroundColor:
                                    Theme.of(context).highlightColor,
                                child: CircleAvatar(
                                  radius: 75.0,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(snapshot
                                                  .data?.avatar ==
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
                            SizedBox(height: 10.0),
                            Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Full Name',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade700,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: nameController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: emailController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade700,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: addressController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Age',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade700,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: ageController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Height (cm)',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade700,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: heightController,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Weight (kg)',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade700,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).highlightColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).highlightColor))),
                        cursorColor: Theme.of(context).highlightColor,
                        onChanged: (value) {
                          onFieldChanged();
                        },
                        controller: weightController,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: changesMade
          ? ConfirmButton(
              onConfirm: () async {
                UserModel user = await userFuture;
                onConfirmButtonPressed(user);
              },
            )
          : null,
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final VoidCallback onConfirm;

  ConfirmButton({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).highlightColor,
      onPressed: onConfirm,
      child: Icon(Icons.check, color: Colors.white),
    );
  }
}
