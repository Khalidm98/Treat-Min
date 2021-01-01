import 'package:flutter/material.dart';
import 'package:treat_min/screens/available_screen.dart';

class SelectScreen extends StatelessWidget {
  static const routeName = '/select';
  final List<Map<String, String>> clinics = [
    {'name': 'Dentist', 'icon': 'assets/icons/tooth.png'},
    {'name': 'Proctologist', 'icon': 'assets/icons/stomach.png'},
    {'name': 'Pulmonologist', 'icon': 'assets/icons/lungs.png'},
    {'name': 'Cardiologist', 'icon': 'assets/icons/heart.png'},
    {'name': 'Hepatologist', 'icon': 'assets/icons/liver.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Outpatient Clinics')),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: theme.accentColor),
                  hintText: 'Enter Search',
                  hintStyle: theme.textTheme.subtitle1
                      .copyWith(color: theme.accentColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.accentColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.accentColor),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: clinics.length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey[300]),
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(clinics[index]['icon'], height: 30),
                      title: Text(
                        clinics[index]['name'],
                        style: theme.textTheme.headline5,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AvailableScreen.routeName,
                          arguments: clinics[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
