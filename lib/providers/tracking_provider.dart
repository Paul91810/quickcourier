import 'package:flutter/material.dart';
import 'package:quickcourier/models/booking_details_model.dart';
import 'package:quickcourier/models/tracking_model.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart'; // ✅ Add this

enum LoadState { idle, loading, success, error }

class TrackingProvider extends ChangeNotifier {
  final trackingCtrl = TextEditingController();

  LoadState state = LoadState.idle;
  Shipment? shipment;
  String? error;

  /// Fetch tracking details
  Future<void> track() async {
    final trackingNumber = trackingCtrl.text.trim();
    if (trackingNumber.isEmpty) return;

    state = LoadState.loading;
    shipment = null;
    error = null;
    notifyListeners();

    try {
      
      final box = await Hive.openBox<BookingModel>('bookings');

      
      final booking = box.values.firstWhereOrNull(
        (b) => b.trackingId == trackingNumber,
      );

      if (booking == null) {
        
        state = LoadState.error;
        error = "No record found for tracking ID $trackingNumber";
      } else {
        
        shipment = Shipment(
          trackingNumber: booking.trackingId,
          status: "In Transit", 
          lastUpdated: DateTime.now(),
          eta: booking.pickupDate.add(const Duration(days: 3)),
          events: [
            TrackingEvent(
              status: "Picked up from sender",
              location: booking.senderAddress,
              time: booking.pickupDate,
            ),
            TrackingEvent(
              status: "In Transit",
              location: "Distribution Center",
              time: DateTime.now(),
            ),
          ],
        );

        state = LoadState.success;
      }
    } catch (e) {
      state = LoadState.error;
      error = "Something went wrong: $e";
    }

    notifyListeners();
  }
}
