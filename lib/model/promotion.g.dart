// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromotionAdapter extends TypeAdapter<Promotion> {
  @override
  final int typeId = 2;

  @override
  Promotion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Promotion()
      ..merchant = fields[0] as String
      ..account = fields[1] as String
      ..id = fields[2] as String
      ..title = fields[3] as String
      ..description = fields[4] as String
      ..img = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Promotion obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.merchant)
      ..writeByte(1)
      ..write(obj.account)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromotionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
