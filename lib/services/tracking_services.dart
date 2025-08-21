import 'package:flutter/services.dart' show rootBundle;
import 'package:quickcourier/models/tracking_model.dart';

class MockTrackingService {
  Future<Shipment?> fetchByTrackingNumber(String trackingNumber) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final jsonStr = await rootBundle.loadString('assets/tracking_data.json');
    final shipments = Shipment.listFromRootJson(jsonStr);

    try {
      return shipments.firstWhere(
        (s) => s.trackingNumber.toLowerCase().trim() == trackingNumber.toLowerCase().trim(),
      );
    } catch (_) {
      return null;
    }
  }
}
