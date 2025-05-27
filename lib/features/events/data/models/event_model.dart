import '../../domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.eventName,
    required super.description,
    required super.startDate,
    required super.endDate,
    required super.specialFeaturesAvailable,
    required super.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      eventName: json['eventName'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      specialFeaturesAvailable: json['specialFeaturesAvailable'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}