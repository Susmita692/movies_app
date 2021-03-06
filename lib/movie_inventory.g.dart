// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_inventory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieInventoryAdapter extends TypeAdapter<MovieInventory> {
  @override
  final int typeId = 0;

  @override
  MovieInventory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieInventory(
      name: fields[0] as String,
      director: fields[1] as String,
      poster: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieInventory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.director)
      ..writeByte(2)
      ..write(obj.poster);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieInventoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
