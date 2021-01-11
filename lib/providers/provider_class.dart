import 'package:flutter/material.dart';
import '../models/reserved_schedule.dart';

class ProviderClass with ChangeNotifier {
  List<bool> vars = [false, false, false];
  List<ReservedSchedule> reservations = [];

  void addReservation(ReservedSchedule scheduleModel) {
    reservations.add(scheduleModel);
    notifyListeners();
  }

  void removeReservation(String id) {
    reservations.removeWhere((element) {
      return element.id == id;
    });
    notifyListeners();
  }

  changeSortPriceHighLow() {
    vars[1] = !vars[1];
    notifyListeners();
  }

  changeSortPriceLowHigh() {
    vars[0] = !vars[0];
    notifyListeners();
  }

  changeSortNearest() {
    vars[2] = !vars[2];
    notifyListeners();
  }
}
