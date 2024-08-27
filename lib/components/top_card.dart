import 'package:flutter/material.dart';
import 'package:incubate_app/presentation/custom_icons_icons.dart';

class TopCard extends StatelessWidget {
  final int kcalPerDay;
  final double bmi;
  final int bb;
  final int goalsDiff;

  const TopCard({
    required this.kcalPerDay,
    required this.bmi,
    required this.bb,
    required this.goalsDiff,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      elevation: 5,
      color: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        // Set your desired height
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          CustomIcons.fast_food,
                          size: 25.0,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Calories per day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 5.0),
                            Text('$kcalPerDay cal',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 0.8,
                width: 0,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          CustomIcons.weight_hanging,
                          size: 20.0,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  "BB: ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('$bb kg',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 0.0),
                            Wrap(
                              children: [
                                Text("BMI: ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text('$bmi',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 0.0),
                            Wrap(
                              children: [
                                Text("Goals: ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    goalsDiff < 0
                                        ? '${bb + goalsDiff} (${goalsDiff} kg)'
                                        : '${bb + goalsDiff} (+${goalsDiff} kg)',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
