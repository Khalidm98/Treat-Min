import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import './info_screen.dart';
import '../localizations/app_localizations.dart';
import '../providers/provider_class.dart';
import '../providers/user_data.dart';
import '../widgets/current_reservation_card.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    final userData = Provider.of<UserData>(context);
    setAppLocalization(context);

    return SafeArea(
      child: userData.isLoggedIn
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                Container(
                  height: 120,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.accentColor, width: 2),
                    image: DecorationImage(
                      image: userData.photo.isEmpty
                          ? AssetImage('assets/images/placeholder.png')
                          : FileImage(File(userData.photo)),
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.of(context).pushNamed(InfoScreen.routeName);
                    },
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.account_circle, color: accent, size: 40),
                  title: Text(getText('name')),
                  subtitle: Text(userData.name),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.date_range, color: accent, size: 40),
                  title: Text(getText('birth')),
                  subtitle: Text(userData.birth.toString().substring(0, 10)),
                ),
                Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.phone_android, color: accent, size: 40),
                  title: Text(getText('phone')),
                  subtitle: Text(userData.phone),
                ),
                Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    getText('condition'),
                    style: theme.textTheme.headline5,
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Blood Pressure: 120/80 (Normal)\n'
                      'Body Fats: 7% (Normal)\n'
                      'PCR Test Result: Negative',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 10),
                  child: Text(
                    getText('reservations'),
                    style: theme.textTheme.headline5,
                  ),
                ),
                Provider.of<ProviderClass>(context).reservations.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: Provider.of<ProviderClass>(context)
                            .reservations
                            .length,
                        itemBuilder: (context, i) => CurrentReservationCard(
                            Provider.of<ProviderClass>(context)
                                .reservations[i]),
                      )
                    : Card(
                        margin: EdgeInsets.all(0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          trailing: Icon(
                            Icons.book,
                            color: theme.accentColor,
                          ),
                          title: Text(
                            getText('no_reservations'),
                            style: theme.textTheme.subtitle2
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                SizedBox(height: 15)
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
                Text(
                  getText('not_logged_in'),
                  style: theme.textTheme.headline5,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    child: Text(getText('log_in')),
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
