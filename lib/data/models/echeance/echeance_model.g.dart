// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echeance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EcheanceModelAdapter extends TypeAdapter<EcheanceModel> {
  @override
  final int typeId = 1;

  @override
  EcheanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EcheanceModel(
      echeanceName: fields[0] as String,
      beginDate: fields[1] as DateTime,
      endDate: fields[2] as DateTime,
      directoryId: fields[3] as int,
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EcheanceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.echeanceName)
      ..writeByte(1)
      ..write(obj.beginDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.directoryId)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EcheanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
