import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:flutter/material.dart';

class GuestVM with ChangeNotifier
{
  GuestVM();

  final List<GuestModel> _guestList = [];
  List<GuestModel> get guestList => _guestList;

  int _count = 0;
  int get count => _count;

  void addGuest(Map<String, dynamic> formValues) {
    _count++;
    notifyListeners();
  }

  updateGuest(int guestId, Map<String, dynamic> formValues) {
    notifyListeners();
  }

  void deleteGuest()
  {
    notifyListeners();
  }
}