import 'package:flutter/material.dart';
import 'package:treat_min/widgets/currentReservationCard.dart';

import 'package:treat_min/models/ProviderClass.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Image.asset('assets/images/health.png', height: 120),
                  Padding(
                    padding: const EdgeInsets.only(top: 85, left: 85),
                    child: CircleAvatar(
                      backgroundColor: theme.accentColor,
                      radius: 18,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 20,
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
              subtitle: Text('Mohamed Salah'),
            ),
            Divider(height: 0),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.date_range, color: accent, size: 40),
              trailing: Icon(Icons.edit, color: theme.accentColor),
              title: Text('Date of Birth'),
              subtitle: Text('15/6/1992'),
            ),
            Divider(height: 0),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.phone_android, color: accent, size: 40),
              trailing: Icon(Icons.edit, color: accent),
              title: Text('Phone Number'),
              subtitle: Text('0112 861 1970'),
            ),
            Divider(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
              child: Text('Health Condition', style: theme.textTheme.headline5),
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
              child: Text('Current Reservations',
                  style: theme.textTheme.headline5),
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
        ),
      ),
    );
  }
}
