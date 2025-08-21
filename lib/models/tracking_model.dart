import 'dart:convert';

class TrackingEvent {
  final DateTime time;
  final String status;
  final String location;

  TrackingEvent({
    required this.time,
    required this.status,
    required this.location,
  });

  factory TrackingEvent.fromJson(Map<String, dynamic> j) => TrackingEvent(
        time: DateTime.parse(j['time'] as String),
        status: j['status'] as String,
        location: j['location'] as String,
      );
}

class Shipment {
  final String trackingNumber;
  final String status; 
  final DateTime? lastUpdated;
  final DateTime? eta; 
  final List<TrackingEvent> events;

  Shipment({
    required this.trackingNumber,
    required this.status,
    required this.lastUpdated,
    required this.eta,
    required this.events,
  });

  factory Shipment.fromJson(Map<String, dynamic> j) => Shipment(
        trackingNumber: j['trackingNumber'] as String,
        status: j['status'] as String,
        lastUpdated: j['lastUpdated'] != null ? DateTime.parse(j['lastUpdated']) : null,
        eta: j['eta'] != null ? DateTime.parse(j['eta']) : null,
        events: (j['events'] as List<dynamic>)
            .map((e) => TrackingEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  static List<Shipment> listFromRootJson(String jsonStr) {
    final root = json.decode(jsonStr) as Map<String, dynamic>;
    final list = (root['shipments'] as List<dynamic>)
        .map((e) => Shipment.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }
}
