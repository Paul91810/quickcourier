import 'package:hive/hive.dart';

part 'booking_details_model.g.dart';

@HiveType(typeId: 0) 
class BookingModel extends HiveObject {
  @HiveField(0)
  String senderName;

  @HiveField(1)
  String senderPhone;

  @HiveField(2)
  String senderAddress;

  @HiveField(3)
  String receiverName;

  @HiveField(4)
  String receiverPhone;

  @HiveField(5)
  String receiverAddress;

  @HiveField(6)
  String packageWeight;

  @HiveField(7)
  DateTime pickupDate;

  @HiveField(8)
  String pickupTime; 

  @HiveField(9)
  double priceEstimation;

  @HiveField(10)
  String trackingId;

  @HiveField(11) 
  DateTime bookingTime;

  BookingModel({
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.packageWeight,
    required this.pickupDate,
    required this.pickupTime,
    required this.priceEstimation,
    required this.trackingId,
    required this.bookingTime, 
  });
}
