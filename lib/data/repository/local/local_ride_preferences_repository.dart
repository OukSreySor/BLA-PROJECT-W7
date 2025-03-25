import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preference_dto.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository{
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<void> addPastPreference(RidePreference preference) async{
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    final jsonPreference = jsonEncode(RidePreferenceDto.toJson(preference));

    if(!prefsList.contains(jsonPreference)) {
       prefsList.add(jsonPreference);

       // Save the new list as a string list
      await prefs.setStringList(
        _preferencesKey,
        prefsList
      );

    }
    print('Saved ride preference: $jsonPreference');
  }

  @override
  Future<List<RidePreference>> getPastPreferences() async{
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Get the string list form the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];

    // Convert the string list to a list of RidePreferences – Using map()
    return prefsList.map((json) => RidePreferenceDto.fromJson(jsonDecode(json))).toList();
  }

}