import 'package:flutter/material.dart';
import 'package:treat_min/models/clinicSchedule.dart';
import 'package:treat_min/widgets/doctor_card.dart';
import 'package:treat_min/SearchBar.dart';
import 'package:treat_min/widgets/modal_sheet_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/models/ProviderClass.dart';
import 'dart:ui';


class AvailableScreen extends StatelessWidget {
  static const routeName = '/available';
  final List<bool> isSwitched = [false, false, false];
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
      rating: 4,
    ),
    DoctorCard(
      doctorName: 'Khalid Mohammed Refaat',
      hospitalName: 'EL-Seoudi EL-Almani',
      schedule: [ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM')],
      doctorSpecialty: 'Another Specialist',
      examinationFee: 150,
      rating: 4,
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
    ),
  ];

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
                  "Sort By",
                  style: theme.textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ModalSheetListTile(
                text: "Price Low to High",
                value: Provider.of<ProviderClass>(context).vars[0],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceLowHigh,
              ),
              ModalSheetListTile(
                text: "Price High to Low",
                value: Provider.of<ProviderClass>(context).vars[1],
                onSwitchChange:
                    Provider.of<ProviderClass>(context).changeSortPriceHighLow,
              ),
              ModalSheetListTile(
                text: "Nearest",
                value: Provider.of<ProviderClass>(context).vars[2],
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
    final Map<String, String> clinic =
        (ModalRoute.of(context).settings.arguments) as Map<String, String>;

    doctorListVar.sort((a, b) => a.examinationFee.compareTo(b.examinationFee));
    doctorListVar.reversed.toList();
    List<DoctorCard> doctorList() {
      return doctorListVar.toList();
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
          ...doctorList(),
          SizedBox(height: 11),
        ],
      ),
    );
  }
}
