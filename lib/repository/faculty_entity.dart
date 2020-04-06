import 'package:hive/hive.dart';

part 'faculty_entity.g.dart';

@HiveType(typeId: 0)
class FacultyEntity {
  @HiveField(0)
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

  factory FacultyEntity.fromJson(json) {
    return FacultyEntity(json);
  }
}
