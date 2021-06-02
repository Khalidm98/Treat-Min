import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './available_screen.dart';
import '../api/entities.dart';
import '../localizations/app_localizations.dart';
import '../models/screens_data.dart';
import '../providers/app_data.dart';
import '../utils/enumerations.dart';
import '../widgets/background_image.dart';

class SelectScreen extends StatelessWidget {
  static const String routeName = '/select';

  Future<void> getEntities(BuildContext context, Entity entity) async {
    final response = await EntityAPI.getEntities(context, entity);
    if (!response) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entity = ModalRoute.of(context).settings.arguments;
    final strEntity = entityToString(entity);
    final appData = Provider.of<AppData>(context);
    final list = appData.getEntities(context, entity);
    setAppLocalization(context);

    if (list.isEmpty) {
      getEntities(context, entity);
      return Scaffold(
        appBar: AppBar(title: Text(t(strEntity))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final baseURL = 'https://www.treat-min.com/media/photos/$strEntity';
    final maxID = appData.maxID(entity);
    return Scaffold(
      appBar: AppBar(title: Text(t(strEntity))),
      body: BackgroundImage(
        child: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) {
            return const Divider(
                thickness: 1, height: 1, indent: 10, endIndent: 10);
          },
          itemBuilder: (_, index) {
            final id = list[index]['id'];
            return ListTile(
              leading: id <= maxID
                  ? Image.asset(
                      'assets/icons/$strEntity/$id.png',
                      width: 40,
                      height: 40,
                    )
                  : Image.network(
                      '$baseURL/$id.png',
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          'assets/icons/heart_outlined.png',
                          width: 40,
                          height: 40,
                        );
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
        ),
      ),
    );
  }
}
