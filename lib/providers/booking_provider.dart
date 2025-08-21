import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quickcourier/models/booking_details_model.dart';

class BookingProvider extends ChangeNotifier {
 
  final senderName = TextEditingController();
  final senderPhoneNumber = TextEditingController();
  final senderAddress = TextEditingController();
  final receiverName = TextEditingController();
  final receiverPhoneNumber = TextEditingController();
  final receiverAddress = TextEditingController();
  final packageWeight = TextEditingController();

  DateTime? pickupDate;
  TimeOfDay? pickupTime;

  double? priceEstimation;

 
  final Box<BookingModel> bookingBox = Hive.box<BookingModel>("bookings");

 
  void calculatePrice() {
    if (packageWeight.text.isNotEmpty) {
      final weight = double.tryParse(packageWeight.text);
      if (weight != null) {
        priceEstimation = weight * 50; 
        notifyListeners();
      }
    }
  }


  Future<void> selectPickupDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate != null) {
      pickupDate = pickedDate;
      notifyListeners();
    }
  }

 
  Future<void> selectPickupTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      pickupTime = pickedTime;
      notifyListeners();
    }
  }


BookingModel? getBookingByTrackingId(String trackingId) {
  try {
    return bookingBox.values.firstWhere(
      (booking) => booking.trackingId == trackingId,
    );
  } catch (e) {
    return null; 
  }
}


  
  String _generateTrackingId() {
    final random = Random();
    final number = List.generate(9, (_) => random.nextInt(10)).join();
    return "JB$number";
  }


  String? bookCourier(BuildContext context) {
    if (senderName.text.isEmpty ||
        senderPhoneNumber.text.isEmpty ||
        senderAddress.text.isEmpty ||
        receiverName.text.isEmpty ||
        receiverPhoneNumber.text.isEmpty ||
        receiverAddress.text.isEmpty ||
        packageWeight.text.isEmpty ||
        pickupDate == null ||
        pickupTime == null) {
      return null;
    }

  
    if (senderName.text == receiverName.text &&
        senderPhoneNumber.text == receiverPhoneNumber.text &&
        senderAddress.text == receiverAddress.text) {
      return "Sender and Receiver details cannot be the same!";
    }

   
    final trackingId = _generateTrackingId();

    
    final booking = BookingModel(
      senderName: senderName.text,
      senderPhone: senderPhoneNumber.text,
      senderAddress: senderAddress.text,
      receiverName: receiverName.text,
      receiverPhone: receiverPhoneNumber.text,
      receiverAddress: receiverAddress.text,
      packageWeight: packageWeight.text,
      pickupDate: pickupDate!,
      pickupTime: pickupTime!.format(context),
      priceEstimation: priceEstimation ?? 0,
      trackingId: trackingId,
      bookingTime: DateTime.now(), 
    );

    bookingBox.add(booking); 

    return """
Booking Successful ✅

📦 Tracking ID: $trackingId
From: ${senderName.text}, ${senderPhoneNumber.text}, ${senderAddress.text}
To: ${receiverName.text}, ${receiverPhoneNumber.text}, ${receiverAddress.text}
Weight: ${packageWeight.text} kg
Pickup: ${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year} at ${pickupTime!.format(context)}
Estimated Price: ₹${priceEstimation?.toStringAsFixed(2)}
""";
  }
}
