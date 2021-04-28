import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import './info_screen.dart';
import '../localizations/app_localizations.dart';
import '../providers/provider_class.dart';
import '../providers/user_data.dart';
import '../widgets/clinic_reservation_card.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool expansionListChanger = false;

  noReservation(ThemeData theme) {
    return Card(
      margin: EdgeInsets.all(0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        trailing: Icon(Icons.book, color: theme.accentColor),
        title: Text(
          getText('no_reservations'),
          style:
              theme.textTheme.subtitle2.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    final userData = Provider.of<UserData>(context);
    setAppLocalization(context);

    if (!userData.isLoggedIn) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(height: 50),
            Text(getText('not_logged_in'), style: theme.textTheme.headline5),
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
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              icon: const Icon(Icons.edit),
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pushNamed(InfoScreen.routeName);
              },
            ),
          ),
          const Divider(height: 0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.account_circle, color: accent, size: 40),
            title: Text(getText('name')),
            subtitle: Text(userData.name),
          ),
          const Divider(height: 0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.alternate_email, color: accent, size: 40),
            title: Text(getText('email')),
            subtitle: Text(userData.email),
          ),
          const Divider(height: 0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.phone_android, color: accent, size: 40),
            title: Text(getText('phone')),
            subtitle: Text(userData.phone),
          ),
          const Divider(height: 0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.date_range, color: accent, size: 40),
            title: Text(getText('birth')),
            subtitle: Text(userData.birth.toString().substring(0, 10)),
          ),
          const Divider(height: 0),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              getText('reservations'),
              style: theme.textTheme.headline5,
            ),
          ),
          Provider.of<ProviderClass>(context).reservations.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount:
                      Provider.of<ProviderClass>(context).reservations.length,
                  itemBuilder: (context, i) => ClinicReservationCard(
                      Provider.of<ProviderClass>(context).reservations[i]),
                )
              : noReservation(theme),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              getText('history_reservations'),
              style: theme.textTheme.headline5,
            ),
          ),
          //same list as reservations just for testing
          Provider.of<ProviderClass>(context).reservations.length != 0
              ? Container(
                  decoration: BoxDecoration(
                      border: !expansionListChanger
                          ? Border.all(color: theme.accentColor, width: 2)
                          : Border.all(color: Colors.white, width: 2)),
                  child: ExpansionTile(
                      onExpansionChanged: (bool) {
                        setState(() {
                          expansionListChanger = bool;
                        });
                      },
                      title: !expansionListChanger
                          ? FittedBox(
                              child: Text(
                                  getText('Show your reservations history'),
                                  textAlign: TextAlign.center),
                            )
                          : FittedBox(
                              child: Text(
                                  getText('Hide your reservations history'),
                                  textAlign: TextAlign.center),
                            ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: Provider.of<ProviderClass>(context)
                              .reservations
                              .length,
                          itemBuilder: (context, i) => ClinicReservationCard(
                              Provider.of<ProviderClass>(context)
                                  .reservations[i]),
                        )
                      ]),
                )
              : noReservation(theme),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
