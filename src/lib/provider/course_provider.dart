import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  String search = "";
  String get searchKey => search;

  bool reloadFlag = true;

  void setReloadFlag() {
    reloadFlag = false;
  }

  void setSearch(String keyword) {
    search = keyword;
    reloadFlag = true;
    notifyListeners();
  }
}