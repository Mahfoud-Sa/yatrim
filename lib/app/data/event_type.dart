class EventType {
  final int id;
  final String name;
  final int color;

  const EventType({required this.id, required this.name, required this.color});

  static const List<EventType> values = [
    EventType(id: 1, name: "مناسبة دينية", color: 0xFFC3F224),
    EventType(id: 2, name: "مناسبة وطنية", color: 0xFFED4732),
    EventType(id: 3, name: "اجتماع", color: 0xFF1C4A82),
    EventType(id: 4, name: "مهمة", color: 0xFF7747FD),
    EventType(id: 5, name: "عام", color: 0xFF24E4F2),
    EventType(id: 6, name: "أخرى", color: 0xFF000000),
  ];

  static EventType getById(int id) =>
      values.firstWhere((e) => e.id == id, orElse: () => values.last);
}
