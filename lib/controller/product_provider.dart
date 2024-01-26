import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoesSizes(var newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index && !_shoeSizes[i]['isSelected']) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
}
