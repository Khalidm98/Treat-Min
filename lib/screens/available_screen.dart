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
                      padding: const EdgeInsets.all(20.0),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }
            //
            ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/Tooth.png",
              width: 25.0,
              height: 25.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              "Dentist",
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
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
            icon: Image.asset("assets/icons/Filter.png"),
            onPressed: () {
              print("Hey!");
            },
          ),
          IconButton(
            icon: Image.asset("assets/icons/Sort.png"),
            onPressed: () {
              onSortClick(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
          DoctorCard(),
        ],
        // scrollDirection: Axis.vertical,
      ),
    );
  }
}
