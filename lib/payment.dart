import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  // Function to handle redirection to PhonePe
  void _openPhonePe() async {
    const phonePeUrl = 'phonepe://'; // Replace with the correct URL scheme for PhonePe
    if (await canLaunch(phonePeUrl)) {
      await launch(phonePeUrl);
    } else {
      print('Could not launch PhonePe');
    }
  }

  // Function to handle redirection to Google Pay
  void _openGooglePay() async {
    const googlePayUrl = 'upi://pay'; // Use the UPI URL scheme for Google Pay
    if (await canLaunch(googlePayUrl)) {
      await launch(googlePayUrl);
    } else {
      print('Could not launch Google Pay');
    }
  }

  // Function to handle redirection to Paytm
  void _openPaytm() async {
    const paytmUrl = 'paytmmp://'; // Replace with the correct URL scheme for Paytm
    if (await canLaunch(paytmUrl)) {
      await launch(paytmUrl);
    } else {
      print('Could not launch Paytm');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Payment'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile and Amount Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('lib/asset/dri.png'), // Replace with actual image path
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOHN DOE',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text('Rating: 4.8'),
                    Text('ID: 12345'),
                  ],
                ),
                Spacer(),
                Text(
                  '\$15',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Payment Methods Section
            Text('Select Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('PhonePe'),
              onTap: _openPhonePe,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Google Pay'),
              onTap: _openGooglePay,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Paytm'),
              onTap: _openPaytm,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('After the ride'),
              onTap: () {
                // Handle this option
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Other'),
              onTap: () {
                // Handle this option
              },
            ),
            Spacer(),
            // Take Ride Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Take Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}