import 'package:flutter/material.dart';

class OrderPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 10),
            Text(
              'Order Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for your order. Your items will be delivered shortly.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context); // Close the bottom sheet
            //   },
            //   child: Text('Close'),
            // ),
          ],
        ),
      ),
    );
  }
}

void showOrderPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (BuildContext context) {
      return OrderPopup();
    },
  );
}
