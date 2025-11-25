// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_link_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthLinkModelAdapter extends TypeAdapter<HealthLinkModel> {
  @override
  final int typeId = 3;

  @override
  HealthLinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthLinkModel(
      nameWebStite: fields[0] as String,
      externLink: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HealthLinkModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameWebStite)
      ..writeByte(1)
      ..write(obj.externLink)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthLinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
