// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final int typeId = 0;

  @override
  BookingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModel(
      senderName: fields[0] as String,
      senderPhone: fields[1] as String,
      senderAddress: fields[2] as String,
      receiverName: fields[3] as String,
      receiverPhone: fields[4] as String,
      receiverAddress: fields[5] as String,
      packageWeight: fields[6] as String,
      pickupDate: fields[7] as DateTime,
      pickupTime: fields[8] as String,
      priceEstimation: fields[9] as double,
      trackingId: fields[10] as String,
      bookingTime: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.senderName)
      ..writeByte(1)
      ..write(obj.senderPhone)
      ..writeByte(2)
      ..write(obj.senderAddress)
      ..writeByte(3)
      ..write(obj.receiverName)
      ..writeByte(4)
      ..write(obj.receiverPhone)
      ..writeByte(5)
      ..write(obj.receiverAddress)
      ..writeByte(6)
      ..write(obj.packageWeight)
      ..writeByte(7)
      ..write(obj.pickupDate)
      ..writeByte(8)
      ..write(obj.pickupTime)
      ..writeByte(9)
      ..write(obj.priceEstimation)
      ..writeByte(10)
      ..write(obj.trackingId)
      ..writeByte(11)
      ..write(obj.bookingTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
