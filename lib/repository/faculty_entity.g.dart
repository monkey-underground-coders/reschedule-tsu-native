// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacultyEntityAdapter extends TypeAdapter<FacultyEntity> {
  @override
  final typeId = 0;

  @override
  FacultyEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacultyEntity(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FacultyEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.title);
  }
}
