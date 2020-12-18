import 'package:flutter/material.dart';
import 'package:treat_min/screens/available_screen.dart';

class SelectScreen extends StatelessWidget {
  static const routeName = '/select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Outpatient Clinics'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.green),
                border: InputBorder.none,
                hintText: 'Enter Search',
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
            margin: EdgeInsets.only(left: 30, right: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AddingListView(),
            ),
          ),
        ],
      ),
    );
  }
}

class AddingListView extends StatelessWidget {
  final List<Map<String, String>> clinics = [
    {'name': 'Dentist', 'icon': 'assets/icons/tooth_outlined.png'},
    {'name': 'Proctologist', 'icon': 'assets/icons/stomach.png'},
    {'name': 'Pulmonologist', 'icon': 'assets/icons/lungs.png'},
    {'name': 'Cardiologist', 'icon': 'assets/icons/heart.png'},
    {'name': 'Hepatologist', 'icon': 'assets/icons/liver.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: Image.asset(clinics[index]['icon'], height: 30),
          title: Text(clinics[index]['name'],
              style: TextStyle(
                color: Colors.indigo[800],
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Montserrat',
              )),
          onTap: () {
            Navigator.of(context).pushNamed(AvailableScreen.routeName,
                arguments: clinics[index]);
          },
        );
      },
      itemCount: clinics.length,
    );
  }
}
