import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localizations/app_localizations.dart';
import '../providers/provider_class.dart';
import '../utils/search_bar.dart';
import '../utils/enumerations.dart';
import '../widgets/doctor_card.dart';
import '../models/screens_data.dart';
import '../widgets/modal_sheet_list_tile.dart';

class AvailableScreen extends StatelessWidget {
  static const String routeName = '/available';

  bool isClinic(Entity entity) {
    if (entity == Entity.clinic) {
      return true;
    } else {
      return false;
    }
  }

  fillDetailsList(Entity entity) {
    if (isClinic(entity)) {
      return [
        DoctorCard(
          name: 'Gerges Wageh',
          hospitalName: 'Dar EL-Fouad',
          doctorSpecialty: 'ORTHODONTIC SPECIALIST',
          fees: 50,
          rating: 4,
          hospitalDistance: 90,
          isClinic: true,
        ),
        DoctorCard(
          name: 'Gerges Wageh',
          hospitalName: 'Dar EL-Fouad',
          doctorSpecialty: 'ORTHODONTIC SPECIALIST',
          fees: 50,
          rating: 4,
          hospitalDistance: 90,
          isClinic: true,
        )
      ];
    } else {
      return [
        DoctorCard(
          name: 'Delivery',
          hospitalName: 'Dar EL-Fouad',
          doctorSpecialty: 'ORTHODONTIC SPECIALIST',
          fees: 50,
          rating: 4,
          hospitalDistance: 90,
          isClinic: false,
        ),
        DoctorCard(
          name: 'X-Ray',
          hospitalName: 'Dar EL-Fouad',
          doctorSpecialty: 'ORTHODONTIC SPECIALIST',
          fees: 50,
          rating: 4,
          hospitalDistance: 90,
          isClinic: false,
        )
      ];
    }
  }

  void onSortClick(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                color: theme.primaryColorLight,
                alignment: Alignment.center,
                child: Text(
                  getText('sort'),
                  style: theme.textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ModalSheetListTile(
                text: getText('price_low'),
                value: Provider.of<ProviderClass>(context).sortingVars[0],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceLowHigh,
              ),
              ModalSheetListTile(
                text: getText('price_high'),
                value: Provider.of<ProviderClass>(context).sortingVars[1],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceHighLow,
              ),
              ModalSheetListTile(
                text: getText('nearest'),
                value: Provider.of<ProviderClass>(context).sortingVars[2],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortNearest,
              ),
            ],
          ),
        );
      },
    );
  }

  List<DoctorCard> doctorListSorted(
      BuildContext context, List<DoctorCard> entityDetailsList) {
    if (Provider.of<ProviderClass>(context).sortingVars[0] == true) {
      entityDetailsList.sort((a, b) => a.fees.compareTo(b.fees));
      return entityDetailsList;
    } else if (Provider.of<ProviderClass>(context).sortingVars[1] == true) {
      entityDetailsList.sort((a, b) => a.fees.compareTo(b.fees));
      return entityDetailsList.reversed.toList();
    } else {
      entityDetailsList
          .sort((a, b) => a.hospitalDistance.compareTo(b.hospitalDistance));
      return entityDetailsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectScreenData =
        (ModalRoute.of(context).settings.arguments) as AvailableScreenData;
    List<DoctorCard> entityDetailsList =
        fillDetailsList(selectScreenData.entity);
    setAppLocalization(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(selectScreenData.name['name']),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
            IconButton(
              icon: Image.asset("assets/icons/sort.png", width: 25, height: 25),
              onPressed: () {
                onSortClick(context, theme);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: doctorListSorted(context, entityDetailsList).length,
          itemBuilder: (context, i) {
            return doctorListSorted(context, entityDetailsList)[i];
          },
        ));
  }
}
