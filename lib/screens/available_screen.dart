import 'package:flutter/material.dart';
import 'package:treat_min/widgets/doctor_card.dart';
import 'package:treat_min/SearchBar.dart';
import 'package:treat_min/widgets/modal_sheet_list_tile.dart';
import 'dart:ui';

class AvailableScreen extends StatelessWidget {
  static const routeName = '/available';
  final List<bool> isSwitched = [false, false, false];

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
                value: isSwitched[0],
              ),
              ModalSheetListTile(
                text: "Price High to Low",
                value: isSwitched[1],
              ),
              ModalSheetListTile(
                text: "Nearest",
                value: isSwitched[2],
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
        children: [
          SizedBox(height: 11),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          SizedBox(height: 11),
        ],
        // scrollDirection: Axis.vertical,
      ),
    );
  }
}
