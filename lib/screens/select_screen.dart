import 'package:flutter/material.dart';
import 'package:treat_min/screens/available_screen.dart';

class SelectScreen extends StatelessWidget {
  static const routeName = '/select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Outpatient Clinics'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.green),
                border: InputBorder.none,
                hintText: 'Enter Search',
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Expanded(child: BuildListView()),
        ],
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  final List<Map<String, String>> clinics = [
    {'name': 'Dentist', 'icon': 'assets/icons/tooth.png'},
    {'name': 'Proctologist', 'icon': 'assets/icons/stomach.png'},
    {'name': 'Pulmonologist', 'icon': 'assets/icons/lungs.png'},
    {'name': 'Cardiologist', 'icon': 'assets/icons/heart.png'},
    {'name': 'Hepatologist', 'icon': 'assets/icons/liver.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: clinics.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: Image.asset(clinics[index]['icon'], height: 30),
          title: Text(
            clinics[index]['name'],
            style: TextStyle(
              color: Colors.indigo[800],
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AvailableScreen.routeName,
                arguments: clinics[index]);
          },
        );
      },
    );
  }
}
