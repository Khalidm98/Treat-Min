import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import './tabs_screen.dart';
import '../localizations/app_localization.dart';
import '../providers/app_data.dart';
import '../providers/user_data.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _logOut() {
    final appText = AppLocalization.of(context);
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(appText.getText('log_out_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(appText.getText('no')),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<UserData>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
            child: Text(appText.getText('yes')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appText = AppLocalization.of(context);
    final isLoggedIn = Provider.of<UserData>(context, listen: false).isLoggedIn;
    return Scaffold(
      appBar: AppBar(title: Text(appText.getText('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text(
                appText.getText('language'),
                style: theme.textTheme.headline6,
              ),
              trailing: ToggleSwitch(
                labels: [appText.getText('english'), appText.getText('arabic')],
                minWidth: 75,
                minHeight: 30,
                cornerRadius: 10,
                activeBgColor: theme.primaryColorLight,
                inactiveBgColor: Colors.white,
                onToggle: (index) {
                  final lang = index == 0 ? 'en' : 'ar';
                  Navigator.of(context).pushReplacementNamed(
                    TabsScreen.routeName,
                    arguments: 1,
                  );
                  MyApp.setLocale(context, Locale(lang));
                  Provider.of<AppData>(context, listen: false)
                      .setLanguage(lang);
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
                appText.getText('notifications'),
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
              title: Text(
                appText.getText(isLoggedIn ? 'log_out' : 'log_in'),
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
