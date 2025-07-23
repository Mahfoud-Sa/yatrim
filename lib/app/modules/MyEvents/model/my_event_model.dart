import 'package:yatrim/app/modules/events/model/events_model.dart';

class PersonalEvent {
  final int id;
  final String dateTime;
  final String name;
  final String? description;
  final String dateEnd;
  final EventType typeEvent;
  final int typeLoop;
  final String createdAt;
  final String updatedAt;

  PersonalEvent({
    required this.id,
    required this.dateTime,
    required this.name,
    required this.description,
    required this.dateEnd,
    required this.typeEvent,
    required this.typeLoop,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PersonalEvent.fromJson(
      Map<String, dynamic> json, EventType typeEvent) {
    return PersonalEvent(
      id: json['id'],
      dateTime: json['date_time'],
      name: json['name'],
      description: json['description'] ?? '',
      dateEnd: json['date_end'],
      typeEvent: typeEvent,
      typeLoop: json['type_loop'],
      createdAt: json['create_at'],
      updatedAt: json['update_at'],
    );
  }

  // Getter to parse dateTime and return the date only (YYYY-MM-DD)
  String get dateOnly {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    return '${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')}';
  }

  int get daysToEnd {
    final endDate = DateTime.parse(dateEnd);
    return endDate.difference(DateTime.parse(dateOnly)).inDays;
  }

  // Getter to parse dateTime and return the time only (HH:MM:SS)
  String get timeOnly {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    return '${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')}:${parsedDateTime.second.toString().padLeft(2, '0')}';
  }
}
