import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './available_screen.dart';
import '../providers/app_data.dart';
import '../utils/enumerations.dart';

class SelectScreen extends StatelessWidget {
  static const String routeName = '/select';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final book = (ModalRoute.of(context).settings.arguments) as Book;
    final list = Provider.of<AppData>(context).getBookingList(book);

    return Scaffold(
      appBar: AppBar(title: Text(bookToString(book))),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: list.length,
          separatorBuilder: (_, __) => Divider(thickness: 1, height: 1),
          itemBuilder: (_, index) {
            return ListTile(
              leading: Image.asset(list[index]['icon'], height: 30),
              title: Text(
                list[index]['name'],
                textScaleFactor: 0.8,
                style: theme.textTheme.headline5,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AvailableScreen.routeName,
                  arguments: list[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
