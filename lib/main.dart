import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/data/repository/local/local_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/ui/provider/rides_preferences_provider.dart';
import 'data/repository/mock/mock_locations_repository.dart';
import 'data/repository/mock/mock_rides_repository.dart';
import 'service/locations_service.dart';
import 'service/rides_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  // 1 - Initialize the services
                                                                                                                                                                                                                                                                                                                                  
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());
  LocalRidePreferencesRepository localRidePrefRepo = LocalRidePreferencesRepository();
  // 2- Run the UI
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RidesPreferencesProvider(repository: localRidePrefRepo),
        ),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}


