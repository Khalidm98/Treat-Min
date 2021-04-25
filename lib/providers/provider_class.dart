import 'package:flutter/material.dart';
import '../models/reserved_schedule.dart';
import '../models/reviews.dart';

class ProviderClass with ChangeNotifier {
  List<bool> sortingVars = [false, false, true];
  //for testing purposes
  List<ReservedSchedule> reservations = [];
  List<Reviews> reviews = [];

  void addReview(Reviews review) {
    reviews.add(review);
    notifyListeners();
  }

  void addReservation(
      ReservedSchedule scheduleModel, List<ReservedSchedule> reservations) {
    reservations.add(scheduleModel);
    notifyListeners();
  }

  void removeReservation(String id) {
    reservations.removeWhere((element) {
      return element.id == id;
    });
    notifyListeners();
  }

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
