import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.accentColor;
    return SafeArea(
      child: ListView(
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
            child:
                Text('Current Reservations', style: theme.textTheme.headline5),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Ahmed Khaled",
                    style: theme.textTheme.headline6
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "ORTHODONTIC SPECIALIST",
                    style: theme.textTheme.caption,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Saturday"),
                      Text("01:00 - 08:00"),
                      SizedBox(
                        height: 30,
                        width: 85,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Ahmed Khaled",
                    style: theme.textTheme.headline6
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "ORTHODONTIC SPECIALIST",
                    style: theme.textTheme.caption,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Saturday"),
                      Text("01:00 - 08:00"),
                      SizedBox(
                        height: 30,
                        width: 85,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Ahmed Khaled",
                    style: theme.textTheme.headline6
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "ORTHODONTIC SPECIALIST",
                    style: theme.textTheme.caption,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Saturday"),
                      Text("01:00 - 08:00"),
                      SizedBox(
                        height: 30,
                        width: 85,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }
}
