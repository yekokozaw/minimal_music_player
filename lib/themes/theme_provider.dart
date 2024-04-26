import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  ThemeProvider(){
    _initializeData().then((_){
      notifyListeners();
    });

  }
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;

    notifyListeners();
  }

  void toggleTheme() async{
    if(themeData == lightMode){
      _saveThemePreference(true);
      themeData = darkMode;
    }else{
      _saveThemePreference(false);
      themeData = lightMode;
    }
  }

  Future<void> _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve data from shared preferences and store it in the class variable
    bool theme = prefs.getBool('mode') ?? false;
    if(theme){
      _themeData = darkMode;
    }else{
      _themeData = lightMode;
    }
  }

  // Method to save the theme mode preference
  Future<void> _saveThemePreference(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('mode', isDark);
  }
}