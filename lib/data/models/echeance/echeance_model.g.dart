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
      category: fields[3] as String,
      subType: fields[4] as String?,
      description: fields[5] as String?,
      categoryId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EcheanceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.echeanceName)
      ..writeByte(1)
      ..write(obj.beginDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.subType)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.categoryId);
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
