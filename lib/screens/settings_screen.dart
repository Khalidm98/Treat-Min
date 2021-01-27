import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:treat_min/widgets/translated_text.dart';
import './auth_screen.dart';
import 'package:treat_min/main.dart';
import '../providers/user_data.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _logOut() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: TranslatedText(jsonKey: 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TranslatedText(jsonKey: 'No'),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<UserData>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
            child: TranslatedText(jsonKey: 'Yes'),
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
      appBar: AppBar(
        title: TranslatedText(jsonKey: 'Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: TranslatedText(
                  jsonKey: 'App Language', style: theme.textTheme.headline6),
              trailing: ToggleSwitch(
                initialLabelIndex: translator.currentLanguage == 'en' ? 0 : 1,
                labels: ['English', 'Arabic'],
                minWidth: 75,
                minHeight: 30,
                cornerRadius: 10,
                activeBgColor: theme.primaryColorLight,
                inactiveBgColor: Colors.white,
                onToggle: (index) {
                  if (index == 0) {
                    setState(() {
                      translator.setNewLanguage(
                        context,
                        newLanguage: 'en',
                        remember: true,
                        restart: false,
                      );
                      MyApp.setLocale(context, translator.locale);
                    });
                  } else {
                    setState(() {
                      translator.setNewLanguage(
                        context,
                        newLanguage: 'ar',
                        remember: true,
                        restart: false,
                      );
                      MyApp.setLocale(context, translator.locale);
                    });
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
              value: _notification,
              onChanged: (newVal) {
                setState(() => _notification = newVal);
              },
              title: TranslatedText(
                jsonKey: 'Send Notifications',
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
              title: TranslatedText(
                jsonKey: isLoggedIn ? 'Log out' : 'Log in',
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
