import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  
  static RidePreference fromJson(Map<String, dynamic> json) {
     return RidePreference(
       departure: LocationDto.fromJson(json['departure']), 
       departureDate: DateTime.parse(json['departureDate']),
       arrival: LocationDto.fromJson(json['arrival']), 
       requestedSeats: json['requestedSeats'],
     );
   }

  static Map<String, dynamic> toJson(RidePreference ridePreference) {
    return {
      'departure': LocationDto.toJson(ridePreference.departure),
      'departureDate': ridePreference.departureDate.toIso8601String(),  // Ensure proper storage format
      'arrival': LocationDto.toJson(ridePreference.arrival),
      'requestedSeats': ridePreference.requestedSeats,
    };
  }

  static Country countryFromString(String value) {
    return Country.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Invalid country: $value'),
    );
  }
}