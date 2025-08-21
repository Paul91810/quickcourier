import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quickcourier/models/booking_details_model.dart';
import 'package:quickcourier/providers/theme_notifier.dart';
import 'package:quickcourier/screens/home_screen.dart';


import 'package:quickcourier/providers/tracking_provider.dart';
import 'package:quickcourier/screens/shipment_tracking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Hive.initFlutter();
  Hive.registerAdapter(BookingModelAdapter());
  await Hive.openBox<BookingModel>('bookings');
  await Hive.openBox('settings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => TrackingProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme(context),
          debugShowCheckedModeBanner: false,

         
          home: const ScreenHome(),

        
          routes: {
            '/tracking': (_) => const ShipmentTrackingScreen(),
          },
        );
      },
    );
  }
}
