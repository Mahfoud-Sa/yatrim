class Repetition {
  final int id;
  final String name;

  const Repetition(this.id, this.name);

  static const List<Repetition> values = [
    Repetition(1, "لا يوجد"),
    Repetition(2, "يومي"),
    Repetition(3, "أسبوعي"),
    Repetition(4, "شهري"),
    Repetition(5, "سنوي"),
  ];

  static Repetition getById(int id) =>
      values.firstWhere((e) => e.id == id, orElse: () => values.first);
}
