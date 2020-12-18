import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/app_raised_button.dart';

class  AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 120,
              width: 120,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/health.png'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Color(0xff34bba3),
                    radius: 16,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'New Patient',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
                fontFamily: 'Montserrat',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 35,
              ),
              title: Text('Name',
                  style: TextStyle(
                      color: Colors.teal[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat')),
              subtitle: Text('Mohamed Salah',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
              trailing: Icon(
                Icons.edit,
                color: Colors.teal[800],
              ),
            ),
            Divider(
              color: Colors.black,
              indent: 40,
              endIndent: 40,
              height: 0,
            ),
            ListTile(
              leading: Icon(
                Icons.date_range,
                size: 35,
              ),
              trailing: Icon(
                Icons.edit,
                color: Colors.teal[800],
              ),
              title: Text('Date of birth',
                  style: TextStyle(
                      color: Colors.teal[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat')),
              subtitle: Text('15/6/1992',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
            ),
            Divider(
              color: Colors.black,
              indent: 40,
              endIndent: 40,
              height: 0,
            ),
            ListTile(
              leading: Icon(
                Icons.phone_android,
                size: 35,
              ),
              trailing: Icon(
                Icons.edit,
                color: Colors.teal[800],
              ),
              title: Text('Phone Number',
                  style: TextStyle(
                      color: Colors.teal[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat')),
              subtitle: Text('0112 861 1970',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              width: double.infinity,
              child: Text(
                'Health Condition',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.teal[800],
                    fontFamily: 'Montserrat'),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              shadowColor: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Hello Mohamed,You are 28 years old.\nYour pressure is good. It\'s 80/120.\n'
                  'Your fat is 7%.\nYour blood sugar level is usual.\nYour last PCR test '
                  'in 1/12/2020 was negative.\nTreat-Min wish you a good health always.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.teal[800],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}