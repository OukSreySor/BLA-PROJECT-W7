import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/provider/async_value.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {

  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
  	_fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreferrence(RidePreference pref) {
    if (pref != _currentPreference) {
      _currentPreference = pref;
      notifyListeners();
    }
  }

  void addPreference(RidePreference preference) async {
    await repository.addPreference(preference);
    _fetchPastPreferences();
    notifyListeners();
  }

  void _fetchPastPreferences() async {
    // 1- Handle loading
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      // 2 Fetch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      // 3 Handle success
      pastPreferences = AsyncValue.success(pastPrefs);
      // 4 Handle error
      } catch (error) {
      pastPreferences = AsyncValue.error(error);
      }
      notifyListeners();
      }
    
  //List<RidePreference> get preferenceHistory => pastPreferences.reversed.toList();
}