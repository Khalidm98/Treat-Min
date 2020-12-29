import 'package:flutter/material.dart';
import 'package:treat_min/widgets/doctor_card.dart';
import 'package:treat_min/SearchBar.dart';
import 'package:treat_min/widgets/modal_sheet_list_tile.dart';
import 'dart:ui';

class AvailableScreen extends StatelessWidget {
  static const routeName = '/available';
  final List<bool> isSwitched = [false, false, false];

  void onSortClick(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Color(0xff56c596),
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Sort By",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: doctorCardFontFamily,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                ModalSheetListTile(
                    text: "Price Low to High", value: isSwitched[0]),
                ModalSheetListTile(
                    text: "Price High to Low", value: isSwitched[1]),
                ModalSheetListTile(text: "Nearest", value: isSwitched[2]),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> clinic =
        (ModalRoute.of(context).settings.arguments) as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              clinic['name'],
              style: TextStyle(fontFamily: 'Montserrat'),
              textScaleFactor: 1.2,
            ),
          ),
        ),
        actionsIconTheme: IconThemeData(size: 20),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            icon: Image.asset(
              "assets/icons/Sort.png",
              width: 25,
              height: 25,
            ),
            onPressed: () {
              onSortClick(context);
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
