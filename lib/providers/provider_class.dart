import 'package:flutter/material.dart';

class ProviderClass with ChangeNotifier {
  List<bool> sortingVars = [false, false];
  List<String> city = [];
  List<String> area = [];

  void changeSortPriceLowHigh() {
    sortingVars[0] = !sortingVars[0];
    if (sortingVars[1] == true) {
      sortingVars[1] = false;
      // sortingVars[2] = false;
    }
    // if (sortingVars[0] == false) {
    //   sortingVars[2] = true;
    // }
    notifyListeners();
  }

  void changeSortPriceHighLow() {
    sortingVars[1] = !sortingVars[1];
    if (sortingVars[0] == true) {
      sortingVars[0] = false;
      // sortingVars[2] = false;
    }
    // if (sortingVars[1] == false) {
    //   sortingVars[2] = true;
    // }
    notifyListeners();
  }

  // void changeSortNearest() {
  //   sortingVars[2] = true;
  //
  //   if (sortingVars[0] || sortingVars[1] == true) {
  //     sortingVars[0] = false;
  //     sortingVars[1] = false;
  //   }

  //   notifyListeners();
  // }
}
