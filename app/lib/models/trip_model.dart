class TripModel {

  final String id;

  final String title;

  final String destination;

  final String startLocation;

  final String travelMode;

  final String budget;

  final bool isSolo;

  final int memberCount;

  final String? notes;

  TripModel({
    required this.id,
    required this.title,
    required this.destination,
    required this.startLocation,
    required this.travelMode,
    required this.budget,
    required this.isSolo,
    required this.memberCount,
    this.notes,
  });

  factory TripModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TripModel(
      id: json["id"],

      title: json["title"],

      destination:
          json["destination"],

      startLocation:
          json["start_location"] ?? "",

      travelMode:
          json["travel_mode"] ?? "",

      budget:
          json["budget"].toString(),

      isSolo:
          json["is_solo"] ?? true,

      memberCount:
          json["member_count"] ?? 1,

      notes: json["notes"],
    );
  }
}