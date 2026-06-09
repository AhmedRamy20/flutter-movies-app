// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'movie_hive_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class MovieHiveModelAdapter extends TypeAdapter<MovieHiveModel> {
//   @override
//   final int typeId = 0;

//   @override
//   MovieHiveModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return MovieHiveModel(
//       id: fields[0] as int,
//       title: fields[1] as String,
//       posterPath: fields[2] as String?,
//       overview: fields[3] as String?,
//       backdropPath: fields[4] as String?,
//       voteAverage: fields[5] as double?,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, MovieHiveModel obj) {
//     writer
//       ..writeByte(6)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.title)
//       ..writeByte(2)
//       ..write(obj.posterPath)
//       ..writeByte(3)
//       ..write(obj.overview)
//       ..writeByte(4)
//       ..write(obj.backdropPath)
//       ..writeByte(5)
//       ..write(obj.voteAverage);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is MovieHiveModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
