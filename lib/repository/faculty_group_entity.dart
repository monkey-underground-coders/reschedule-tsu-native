class FacultyGroupEntity {
  // University course of the group
  final int course;

  // Count of subgroups
  final int subgroups;

  // Title of the group
  final String title;

  // Level (Bachelor/Magistracy)
  final String level;

  FacultyGroupEntity(
    this.title,
    this.level,
    this.course,
    this.subgroups,
  );

  @override
  int get hashCode => title.hashCode ^ course.hashCode & subgroups.hashCode ^ level.hashCode;

  @override
  bool operator ==(Object o) =>
      identical(this, o) ||
      o is FacultyGroupEntity &&
          title == o.title &&
          course == o.course &&
          subgroups == o.subgroups &&
          level == o.level;

  @override
  String toString() {
    return 'FacultyGroupEntity{title: $title, course: $course, subgroups: $subgroups, level: $level}';
  }

  Map<String, Object> toJSON() {
    return {
      'title': title,
      'course': course,
      'subgroups': subgroups,
      'level': level,
    };
  }

  static FacultyGroupEntity fromJSON(Map<String, Object> json) {
    return FacultyGroupEntity(
      json['title'] as String,
      json['level'] as String,
      json['course'] as int,
      json['subgroups'] as int,
    );
  }
}
