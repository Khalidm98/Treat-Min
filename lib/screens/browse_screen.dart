import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treat_min/widgets/doctor_card.dart';
import 'package:treat_min/SearchBar.dart';
import 'package:treat_min/widgets/modal_sheet_list_tile.dart';

class BrowseScreen extends StatefulWidget {
  static const routeName = '/browse';
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSwitched = [false, false, false];
    void onSortClick() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
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
                    text: "Price Low to High", val: isSwitched[0]),
                ModalSheetListTile(
                    text: "Price High to Low", val: isSwitched[1]),
                ModalSheetListTile(text: "Nearest", val: isSwitched[2]),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: null,
          //TODO:need to add functionality to pop the last screen in stack
          // Navigator.pop(context, false);
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
              onSortClick();
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
