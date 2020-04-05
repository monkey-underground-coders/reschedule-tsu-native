class FacultyEntity {
  final String title;

  FacultyEntity(this.title);

  @override
  int get hashCode => title.hashCode;

  @override
  bool operator ==(Object o) => identical(this, o) || o is FacultyEntity && title == o.title;

  @override
  String toString() {
    return 'FacultyEntity{title: $title}';
  }

  Map<String, Object> toJSON() {
    return {'title': title};
  }

  static FacultyEntity fromJSON(Map<String, Object> json) {
    return FacultyEntity(json['title'] as String);
  }
}
