import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localizations/app_localization.dart';
import '../models/clinic_schedule.dart';
import '../providers/provider_class.dart';
import '../utils/search_bar.dart';
import '../widgets/doctor_card.dart';
import '../widgets/modal_sheet_list_tile.dart';

class AvailableScreen extends StatelessWidget {
  static const String routeName = '/available';
  final List<DoctorCard> doctorListVar = [
    DoctorCard(
      doctorName: 'Gerges Wageh',
      hospitalName: 'Dar EL-Fouad',
      schedule: [
        ClinicSchedule(day: 'Wednesday', time: '9:00 PM - 12:00 PM'),
        ClinicSchedule(day: 'Sunday', time: '12:00 PM - 14:00 PM'),
        ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM')
      ],
      doctorSpecialty: 'ORTHODONTIC SPECIALIST',
      examinationFee: 50,
      rating: 4,
      hospitalDistance: 90,
    ),
    DoctorCard(
      doctorName: 'Ahmed Khaled Sayed',
      hospitalName: 'EL-Kahrba',
      schedule: [
        ClinicSchedule(day: 'Sunday', time: '12:00 PM - 14:00 PM'),
        ClinicSchedule(day: 'Sunday', time: '11:00 PM - 12:00 PM'),
        ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM'),
      ],
      doctorSpecialty: 'ORTHODONTIC SPECIALIST',
      examinationFee: 250,
      rating: 3,
      hospitalDistance: 10,
    ),
    DoctorCard(
      doctorName: 'Khalid Mohammed Refaat',
      hospitalName: 'EL-Seoudi EL-Almani',
      schedule: [ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM')],
      doctorSpecialty: 'Another Specialist',
      examinationFee: 150,
      rating: 5,
      hospitalDistance: 20,
    ),
    DoctorCard(
      doctorName: 'Mohamed Ramadan',
      hospitalName: 'EL-Nile',
      schedule: [
        ClinicSchedule(day: 'Wednesday', time: '9:00 PM - 12:00 PM'),
        ClinicSchedule(day: 'Monday', time: '12:00 PM - 14:00 PM'),
        ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM')
      ],
      doctorSpecialty: 'Dentistry SPECIALIST',
      examinationFee: 350,
      rating: 4,
      hospitalDistance: 30,
    ),
  ];

  void onSortClick(BuildContext context, ThemeData theme) {
    final appText = AppLocalization.of(context);
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
                  appText.getText('sort'),
                  style: theme.textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ModalSheetListTile(
                text: appText.getText('price_low'),
                value: Provider.of<ProviderClass>(context).sortingVars[0],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceLowHigh,
              ),
              ModalSheetListTile(
                text: appText.getText('price_high'),
                value: Provider.of<ProviderClass>(context).sortingVars[1],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceHighLow,
              ),
              ModalSheetListTile(
                text: appText.getText('nearest'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clinic =
        (ModalRoute.of(context).settings.arguments) as Map<String, String>;

    List<DoctorCard> doctorListSorted() {
      if (Provider.of<ProviderClass>(context).sortingVars[0] == true) {
        doctorListVar
            .sort((a, b) => a.examinationFee.compareTo(b.examinationFee));
        return doctorListVar;
      } else if (Provider.of<ProviderClass>(context).sortingVars[1] == true) {
        doctorListVar
            .sort((a, b) => a.examinationFee.compareTo(b.examinationFee));
        return doctorListVar.reversed.toList();
      } else {
        doctorListVar
            .sort((a, b) => a.hospitalDistance.compareTo(b.hospitalDistance));
        return doctorListVar;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(clinic['name']),
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
      body: ListView(
        //shrinkWrap: true,
        children: [
          SizedBox(height: 11),
          ...doctorListSorted(),
          SizedBox(height: 11),
        ],
      ),
    );
  }
}
