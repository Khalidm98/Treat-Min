import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import '../providers/provider_class.dart';
import '../providers/user_data.dart';
import '../widgets/current_reservation_card.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    final userData = Provider.of<UserData>(context, listen: false);
    return SafeArea(
      child: userData.isLoggedIn
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.accentColor,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: userData.photo.isEmpty
                                ? AssetImage('assets/images/placeholder.png')
                                : FileImage(File(userData.photo)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80, left: 80),
                        child: CircleAvatar(
                          backgroundColor: theme.accentColor,
                          radius: 20,
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.account_circle, color: accent, size: 40),
                  trailing: Icon(Icons.edit, color: theme.accentColor),
                  title: Text('Name'),
                  subtitle: Text(userData.name),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.date_range, color: accent, size: 40),
                  trailing: Icon(Icons.edit, color: theme.accentColor),
                  title: Text('Date of Birth'),
                  subtitle: Text(userData.birth.toString().substring(0, 10)),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.phone_android, color: accent, size: 40),
                  trailing: Icon(Icons.edit, color: accent),
                  title: Text('Phone Number'),
                  subtitle: Text(userData.phone),
                ),
                Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    'Health Condition',
                    style: theme.textTheme.headline5,
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Age: 28 years\n'
                      'Blood Pressure: 120/80 (Normal)\n'
                      'Body Fats: 7% (Normal)\n'
                      'PCR Test Result: Negative',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    'Current Reservations',
                    style: theme.textTheme.headline5,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:
                  Provider.of<ProviderClass>(context).reservations.length,
                  itemBuilder: (context, i) => CurrentReservationCard(
                      Provider.of<ProviderClass>(context).reservations[i]),
                ),
                SizedBox(height: 25)
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 50),
                Text('You are not logged in', style: theme.textTheme.headline5),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    child: Text('Log in'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
