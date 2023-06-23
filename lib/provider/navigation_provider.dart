import 'package:flutter/material.dart';
import 'package:job_app/models/navigation.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.splash;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem){
    _navigationItem = navigationItem;
    notifyListeners();
  }
}