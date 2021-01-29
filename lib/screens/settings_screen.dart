import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import './tabs_screen.dart';
import '../localizations/app_localizations.dart';
import '../providers/app_data.dart';
import '../providers/user_data.dart';

class SettingsScreen extends StatelessWidget {
  void _logOut(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(getText('log_out_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(getText('no')),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<UserData>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
            child: Text(getText('yes')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appData = Provider.of<AppData>(context);
    final isLoggedIn = Provider.of<UserData>(context, listen: false).isLoggedIn;
    setAppLocalization(context);

    return Scaffold(
      appBar: AppBar(title: Text(getText('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text(
                getText('language'),
                style: theme.textTheme.headline6,
              ),
              trailing: ToggleSwitch(
                labels: [getText('english'), getText('arabic')],
                minWidth: 75,
                minHeight: 30,
                cornerRadius: 10,
                initialLabelIndex: appData.language == 'en' ? 0 : 1,
                activeBgColor: theme.primaryColorLight,
                inactiveBgColor: Colors.white,
                onToggle: (index) {
                  final lang = index == 0 ? 'en' : 'ar';
                  if (lang != appData.language) {
                    Navigator.of(context).pushReplacementNamed(
                      TabsScreen.routeName,
                      arguments: 1,
                    );
                    appData.setLanguage(context, lang);
                  }
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
              value: appData.notifications,
              onChanged: (val) => appData.setNotifications(val),
              title: Text(
                getText('notifications'),
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
                getText(isLoggedIn ? 'log_out' : 'log_in'),
                style: theme.textTheme.headline6,
              ),
              trailing: InkWell(
                onTap: isLoggedIn
                    ? () => _logOut(context)
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
