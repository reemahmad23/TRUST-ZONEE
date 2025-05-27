class Event {
  final int id;
  final String eventName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String specialFeaturesAvailable;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.eventName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.specialFeaturesAvailable,
    required this.createdAt,
  });
}