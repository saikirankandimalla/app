import 'package:app/home.dart';
import 'package:flutter/material.dart';





class sidepage extends StatelessWidget {
  const sidepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
         leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/asset/image.png'), // Replace with your image asset
              ),
            ),
            const Text(
              'saikiran>',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Payments'),
              onTap: () {
                // Handle Payments tap
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                // Handle History tap
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                // Handle About tap
              },
            ),
            ListTile(
              title: const Text('Support'),
              onTap: () {
                // Handle Support tap
              },
            ),
             ListTile(
              title: const Text('Setting'),
              onTap: () {
                // Handle History tap
              },),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Handle Logout tap
              },
            ),
          ],
        ),
      ),
    );
  }
}