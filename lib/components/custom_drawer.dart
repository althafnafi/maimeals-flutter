import 'package:flutter/material.dart';
import 'package:incubate_app/core/api_client.dart';
import 'package:incubate_app/screens/auth.dart';

class CustomDrawer extends StatelessWidget {
  final String? profilePictureUrl;
  final String name;
  final String email;
  final String? userId;

  const CustomDrawer({
    this.profilePictureUrl,
    required this.name,
    required this.email,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(profilePictureUrl == "" ||
                          profilePictureUrl == null
                      ? ApiClient.getFileUrl('users', profilePictureUrl ?? '',
                          profilePictureUrl ?? '')
                      : "http://143.198.194.194:8090/api/files/lbzfu35fowpcgfe/1pn13waid8unff3/male_placeholder_lqibmv7_kt2_pwyxqMIrn7.jpg?token="),
                ),
                SizedBox(height: 10.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerCategory(
            'Information',
            [
              _buildDrawerItem(
                Icons.calendar_today,
                'Planner',
                () {
                  // Handle Planner tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Planner
                },
              ),
              _buildDrawerItem(
                Icons.accessibility,
                'Physical Stats',
                () {
                  // Handle Physical Stats tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Physical Stats
                },
              ),
              _buildDrawerItem(
                Icons.line_weight,
                'Weight Goal',
                () {
                  // Handle Weight Goal tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Weight Goal
                },
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Divider(
            color: Colors.black12,
            endIndent: 30,
            indent: 10,
            thickness: 1.0,
          ),
          _buildDrawerCategory(
            'Preferences',
            [
              _buildDrawerItem(
                Icons.settings,
                'Meal Preferences',
                () {
                  // Handle Meal Preferences tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Meal Preferences
                },
              ),
              _buildDrawerItem(
                Icons.fastfood,
                'Nutrition Targets',
                () {
                  // Handle Nutrition Targets tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Nutrition Targets
                },
              ),
              _buildDrawerItem(
                Icons.not_interested,
                'Food Exclusions',
                () {
                  // Handle Food Exclusions tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Food Exclusions
                },
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Divider(
            color: Colors.black12,
            endIndent: 30,
            indent: 10,
            thickness: 1.0,
          ),
          _buildDrawerCategory(
            'Account',
            [
              _buildDrawerItem(
                Icons.swap_horiz,
                'Switch Account',
                () {
                  // Handle Switch Account tap
                  Navigator.pop(context); // Close the drawer
                  // You can navigate to a new screen for Switch Account
                },
              ),
              _buildDrawerItem(
                Icons.logout,
                'Log Out',
                () {
                  // Handle Log Out tap
                  Navigator.of(context)
                      .popUntil((route) => false); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                    ),
                  );
                  // Add your logic for Log Out action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerCategory(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildDrawerItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: onTap,
    );
  }
}
