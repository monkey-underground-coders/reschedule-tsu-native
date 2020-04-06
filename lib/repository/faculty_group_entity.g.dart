// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_group_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacultyGroupEntityAdapter extends TypeAdapter<FacultyGroupEntity> {
  @override
  final typeId = 1;

  @override
  FacultyGroupEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacultyGroupEntity(
      fields[2] as String,
      fields[3] as String,
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FacultyGroupEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.course)
      ..writeByte(1)
      ..write(obj.subgroups)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.level);
  }
}
