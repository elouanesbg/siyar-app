import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    initialState();
  }
  double _fontSize = 18;
  double get getFontSize => _fontSize;
  void setFontSize(double val) {
    _fontSize = val;
    updateSharedPrefrences("fontSize", val);
    notifyListeners();
  }

  String _searchIn = "name";
  String get getsearchIn => _searchIn;
  void setsearchIn(String val) {
    _searchIn = val;
    updateSharedPrefrences("searchIn", val);
    notifyListeners();
  }

  void initialState() {
    syncDataWithProvider();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fontSize = prefs.getDouble('fontSize');
    var searchIn = prefs.getString('searchIn');

    if (fontSize != null) {
      _fontSize = fontSize;
    }
    if (searchIn != null) {
      searchIn = searchIn;
    }
    notifyListeners();
  }

  Future updateSharedPrefrences(String type, var val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case "fontSize":
        await prefs.setDouble(type, val);
        break;
      case "searchIn":
        await prefs.setString(type, val);
        break;
    }
  }
}
