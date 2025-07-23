class Event {
  final int id;
  final String name;
  final String description;
  final String iamge;
  final int day;
  final int month;
  final int typeDate;
  final String? note;
  final String createAt;
  final String updateAt;

  Department? department;
  EventType? eventType;
  City? city;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.iamge,
    required this.day,
    required this.month,
    required this.typeDate,
    this.note,
    required this.createAt,
    required this.updateAt,
    this.department,
    this.eventType,
    this.city,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iamge: json['iamge'],
      day: json['day'],
      month: json['month'],
      typeDate: json['type_date'],
      note: json['note'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
      // نحفظ الـ id مؤقتًا داخل المتغيرات الكائنات كمفتاح
      department: Department(id: json['departmant'], name: ''),
      eventType: EventType(id: json['event_type'], name: '', color: ''),
      city: City(id: json['city'], name: ''),
    );
  }
}

class Department {
  final int id;
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
    );
  }
}

class EventType {
  final int id;
  final String name;
  final String color;

  EventType({required this.id, required this.name, required this.color});

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}
