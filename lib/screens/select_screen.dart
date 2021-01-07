import 'package:flutter/material.dart';
import 'package:treat_min/screens/available_screen.dart';

import '../models/app_enums.dart';

class SelectScreen extends StatelessWidget {
  static const String routeName = '/select';
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
    final Book book = (ModalRoute.of(context).settings.arguments) as Book;
    return Scaffold(
      appBar: AppBar(title: Text(bookToString(book))),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search, color: theme.accentColor),
            //       hintText: 'Enter Search',
            //       hintStyle: TextStyle(color: theme.accentColor),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: BorderSide(color: theme.accentColor),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: BorderSide(color: theme.accentColor),
            //       ),
            //     ),
            //   ),
            // ),
            // Divider(thickness: 1, height: 1, indent: 20, endIndent: 20),
            book == Book.clinic
                ? Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: clinics.length,
                      separatorBuilder: (_, index) {
                        return Divider(thickness: 1, height: 1);
                      },
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading:
                              Image.asset(clinics[index]['icon'], height: 30),
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
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
