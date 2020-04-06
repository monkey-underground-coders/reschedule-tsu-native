import 'package:hive/hive.dart';

part 'faculty_group_entity.g.dart';

@HiveType(typeId: 1)
class FacultyGroupEntity {
  @HiveField(0)
  final int course;

  @HiveField(1)
  final int subgroups;

  @HiveField(2)
  final String title;

  @HiveField(3)
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

  factory FacultyGroupEntity.fromJson(Map<String, dynamic> json) {
    return FacultyGroupEntity(
      json['name'] as String,
      json['level'] as String,
      json['course'] as int,
      json['subgroups'] as int,
    );
  }
}
