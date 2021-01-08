import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import '../models/app_enums.dart';
import '../providers/user_data.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Language _language = Language.English;
  bool _notification = false;

  void _logOut() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<UserData>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoggedIn = Provider.of<UserData>(context, listen: false).isLoggedIn;
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(15),
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
              title: Text(
                isLoggedIn ? 'Log Out' : 'Log In',
                style: theme.textTheme.headline6,
              ),
              trailing: InkWell(
                onTap: isLoggedIn
                    ? () => _logOut()
                    : () {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthScreen.routeName);
                      },
                splashColor: theme.primaryColorDark,
                child: CircleAvatar(
                  backgroundColor: theme.primaryColorLight,
                  child: Icon(
                    isLoggedIn ? Icons.logout : Icons.login,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
