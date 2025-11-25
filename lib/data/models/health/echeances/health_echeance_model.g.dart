// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_echeance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthEcheanceModelAdapter extends TypeAdapter<HealthEcheanceModel> {
  @override
  final int typeId = 4;

  @override
  HealthEcheanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthEcheanceModel(
      nameString: fields[0] as String,
      beginDate: fields[1] as DateTime,
      endDate: fields[2] as DateTime?,
      echeanceDuration: fields[3] as Duration?,
      typeEcheance: fields[4] as String?,
      description: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthEcheanceModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nameString)
      ..writeByte(1)
      ..write(obj.beginDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.echeanceDuration)
      ..writeByte(4)
      ..write(obj.typeEcheance)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthEcheanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
