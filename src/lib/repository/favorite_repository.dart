import 'package:flutter/material.dart';

class FavouriteRepository extends ChangeNotifier {
  List<String> itemIds = [];

  void setListIds(List<String> id) {
    itemIds = id;
  }

  void add(String teacherId) {
    itemIds.add(teacherId);
    notifyListeners();
  }

  void remove(String teacherId) {
    itemIds.remove(teacherId);
    notifyListeners();
  }
}