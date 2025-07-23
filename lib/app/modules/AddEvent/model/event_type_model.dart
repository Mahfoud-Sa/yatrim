class PersonalEvent {
  String? dateTime;
  String? name;
  String? description;
  String? dateEnd;
  String? typeEvent;
  int? typeLoop;

  PersonalEvent({
    this.dateTime,
    this.name,
    this.description,
    this.dateEnd,
    this.typeEvent,
    this.typeLoop,
  });

  factory PersonalEvent.fromJson(Map<String, dynamic> json) {
    return PersonalEvent(
      dateTime: json['date_time'],
      name: json['name'],
      description: json['description'],
      dateEnd: json['date_end'],
      typeEvent: json['type_event'],
      typeLoop: json['type_loop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_time': dateTime,
      'name': name,
      'description': description,
      'date_end': dateEnd,
      'type_event': typeEvent,
      'type_loop': typeLoop,
    };
  }
}
