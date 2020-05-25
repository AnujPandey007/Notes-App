// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social-post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SocialPostAdapter extends TypeAdapter<SocialPost> {
  @override
  SocialPost read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialPost(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SocialPost obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.topic)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.upvotes)
      ..writeByte(8)
      ..write(obj.downvotes);
  }

  @override
  int get typeId => 1;
}
