import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
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
            SizedBox(
              width: 300,
              height: 0,
              child: Divider(
                color: Colors.black,
                //indent: 200,
              ),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
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
            SizedBox(
              width: 300,
              height: 0,
              child: Divider(
                color: Colors.black,
                //indent: 200,
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
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
            Text(
              'Health Condition',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.teal[800],
                  fontFamily: 'Montserrat'),
            ),
            Card(
              //color: Colors.grey[300],
              shadowColor: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Hello Mohamed,You are 28 years old.\nYour pressure is good. It\'s 80/120.\n'
                  'Your fat is 7%.\nYour blood sugar level is usual.\nYour last PCR test '
                  'in 1/12/2020 was negative.\nTreat-Min wish you a good health always.\n',
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
