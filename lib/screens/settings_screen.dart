import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff56c596),
        title: Center(child: Text('Settings')),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          SettingCard('App language'),
          Divider(height: 10),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(0),
            color: Color(0xFFE0ECDE),
            child: SwitchListTile(
              value: _notification,
              onChanged: (newVal) {
                setState(() => _notification = newVal);
              },
              title: Text(
                'Send Notifications',
                style: const TextStyle(fontSize: 24),
              ),
              activeColor: Colors.white,
              activeTrackColor: Color(0xff56c596),
              inactiveThumbColor: Color(0xff56c596),
              inactiveTrackColor: Colors.white,
            ),
          ),
          Divider(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              enabled: true,
              tileColor: Color(0xFFE0ECDE),
              title: Text('My Account', style: TextStyle(fontSize: 24)),
              leading: CircleAvatar(
                backgroundColor: Color(0xff56c596),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
          Divider(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              tileColor: Color(0xFFE0ECDE),
              title: Text('Log out', style: TextStyle(fontSize: 24)),
              trailing: CircleAvatar(
                backgroundColor: Color(0xff56c596),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.logout),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingCard extends StatefulWidget {
  final String text;

  SettingCard(this.text);

  @override
  _SettingCardState createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  bool val = true;

  void changeVal(bool newVal) {
    val = newVal;
  }

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(0),
      color: Color(0xFFE0ECDE),
      child: ListTile(
        title: Text(widget.text, style: TextStyle(fontSize: 24)),
        trailing: ToggleSwitch(
          fontSize: 12,
          cornerRadius: 10,
          labels: ['English', 'Arabic'],
          activeBgColor: Color(0xff56c596),
          inactiveBgColor: Colors.white,
          minWidth: 60,
          minHeight: 30,
        ),
      ),
    );
  }
}
