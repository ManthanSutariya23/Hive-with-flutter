// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransectionAdapter extends TypeAdapter<Transection> {
  @override
  final int typeId = 0;

  @override
  Transection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transection()
      ..amount = fields[0] as int
      ..name = fields[1] as String
      ..date = fields[2] as String
      ..isExpense = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, Transection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
