import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff56c596),
        title: Center(
          child: Text("Settings"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(
          15.0,
        ),
        child: ListView(
          children: <Widget>[
            SettingCard('App language'),
            Divider(
              height: 10,
            ),
            SwitchCard('Send notification'),
            Divider(
              height: 10,
            ),
            //Account Widget
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                enabled: true,
                tileColor: Color(0xFFE0ECDE),
                title: Text(
                  'My Account',
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                ),
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
            Divider(
              height: 10,
            ),
            //Log Out Widget
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                tileColor: Color(0xFFE0ECDE),
                title: Text(
                  'Log out',
                  style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                ),
                trailing: CircleAvatar(
                  backgroundColor: Color(0xff56c596),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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
        title: Text(
          widget.text,
          style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
        ),
        trailing: ToggleSwitch(
          fontSize: 12,
          cornerRadius: 10,
          labels: ["English", "Arabic"],
          activeBgColor: Color(0xff56c596),
          inactiveBgColor: Colors.white,
          minWidth: 60,
          minHeight: 30,
        ),
      ),
    );
  }
}

class SwitchCard extends StatefulWidget {
  final String text;
  SwitchCard(this.text);
  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
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
        title: Text(
          widget.text,
          style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
        ),
        trailing: Switch(
          value: val,
          onChanged: (bool newVal) {
            setState(() {
              changeVal(newVal);
            });
          },
          activeColor: Colors.white,
          inactiveTrackColor: Colors.white,
          activeTrackColor: Color(0xff56c596),
          inactiveThumbColor: Color(0xff56c596),
        ),
      ),
    );
  }
}
