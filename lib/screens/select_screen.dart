import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './available_screen.dart';
import '../api/entities.dart';
import '../localizations/app_localizations.dart';
import '../providers/app_data.dart';
import '../utils/enumerations.dart';
import '../models/screens_data.dart';

class SelectScreen extends StatelessWidget {
  static const String routeName = '/select';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entity = ModalRoute.of(context).settings.arguments;
    setAppLocalization(context);

    return Scaffold(
      appBar: AppBar(title: Text(getText(entityToString(entity)))),
      body: FutureBuilder(
        future: EntityAPI.getEntities(context, entity),
        builder: (_, response) {
          if (response.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (response.data is String) {
            return Center(
              child: Text(response.data, style: theme.textTheme.headline6),
            );
          }
          final list =
              Provider.of<AppData>(context, listen: false).getEntities(entity);
          final baseURL =
              'https://www.treat-min.com/media/photos/${entityToString(entity)}';
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) {
              return const Divider(
                  thickness: 1, height: 1, indent: 10, endIndent: 10);
            },
            itemBuilder: (_, index) {
              return ListTile(
                leading: Image.network(
                  '$baseURL/${list[index]['id']}.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (_, __, ___) {
                    return Image.asset('assets/icons/default.png', width: 40);
                  },
                ),
                title: Text(
                  list[index]['name'],
                  textScaleFactor: 0.8,
                  style: theme.textTheme.headline5,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AvailableScreen.routeName,
                    arguments: AvailableScreenData(list[index], entity),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
