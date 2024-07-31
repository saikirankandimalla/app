import 'dart:convert';

import 'package:app/booking.dart';
import 'package:app/sidepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _getCurrentLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // Convert coordinates to an address or location name
      String locationName =
          'Lat: ${position.latitude}, Long: ${position.longitude}'; // Simplified location
      setState(() {
        _searchController.text = locationName;
      });
    } catch (e) {
      // Handle location permission denied or other errors
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to get location')));
    }
  }

  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadData() async {
    final String response =
        await rootBundle.loadString('lib/assets/countries.json');
    final data = await json.decode(response);
    setState(() {
      _allData = data;
      _filteredData = data;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _allData.where((item) {
        final name = item['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const sidepage()),
              );
            },
          ),
        ),
        title: const Text(
          'ANYTIME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/asset/car.png'), // Your logo image
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for destinations?',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              onTap: () {
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      final item = _filteredData[index];
                      return ListTile(
                        title: Text(item['name']),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 225, 104, 104),
              child:
                  const Center(child: Text('Map goes here')), // Map placeholder
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearby Drivers',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons
                              .location_on), // Change search icon to location icon
                          hintText: 'Enter location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _filteredData.length,
                          itemBuilder: (context, index) {
                            final item = _filteredData[index];
                            return ListTile(
                              title: Text(item['name']),
                            );
                          },
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons
                            .my_location), // Icon for getting current location
                        onPressed: () {
                          _getCurrentLocation(context);
                        },
                      ),
                      const SizedBox(width: 8.0), // Space between icon and text
                      TextButton(
                        onPressed: () {
                          _getCurrentLocation(context);
                        },
                        child: const Text('Get Current Location'),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                DriverCard(
                    name: 'John Doe', carModel: 'Toyota Prius', rating: 4.8),
                DriverCard(
                    name: 'Jane Smith', carModel: 'Honda Civic', rating: 4.6),
                DriverCard(
                    name: '"Mike Johnson',
                    carModel: '"Ford Fusion',
                    rating: 4.7),

                // Add more DriverCard widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final String name;
  final String carModel;
  final double rating;

  const DriverCard(
      {super.key,
      required this.name,
      required this.carModel,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/image.png', height: 40),
              // Car image placeholder
              const SizedBox(height: 20),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(carModel),
              Text('Rating: $rating'),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Booking()));
        },
      ),
    );
  }
}