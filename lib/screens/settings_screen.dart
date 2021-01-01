import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import './auth_screen.dart';

enum Language { Arabic, English }

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Language _language = Language.English;
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text('App Language', style: theme.textTheme.headline6),
              trailing: ToggleSwitch(
                labels: ['English', 'Arabic'],
                minWidth: 75,
                minHeight: 30,
                cornerRadius: 10,
                activeBgColor: theme.primaryColorLight,
                inactiveBgColor: Colors.white,
                onToggle: (index) {
                  if (index == 0) {
                    _language = Language.English;
                  } else {
                    _language = Language.Arabic;
                  }
                  print(_language);
                },
              ),
            ),
          ),
          SizedBox(height: 15),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(0),
            color: Colors.grey[300],
            child: SwitchListTile(
              value: _notification,
              onChanged: (newVal) {
                setState(() => _notification = newVal);
              },
              title: Text(
                'Send Notifications',
                style: theme.textTheme.headline6,
              ),
              activeColor: Colors.white,
              activeTrackColor: theme.primaryColorLight,
              inactiveThumbColor: theme.primaryColorLight,
              inactiveTrackColor: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text('My Account', style: theme.textTheme.headline6),
              leading: CircleAvatar(
                backgroundColor: theme.primaryColorLight,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text('Log Out', style: theme.textTheme.headline6),
              trailing: CircleAvatar(
                backgroundColor: theme.primaryColorLight,
                child: InkWell(
                  child: Icon(Icons.logout, color: Colors.white),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
