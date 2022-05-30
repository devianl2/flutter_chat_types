import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'message.dart';
import 'user.dart';

part 'room.g.dart';

/// All possible room types
enum RoomType { channel, direct, group }

/// A class that represents a room where 2 or more participants can chat
@JsonSerializable()
@immutable
class Room extends Equatable {
  /// Creates a [Room]
  const Room({
    this.createdAt,
    this.id,
    this.imageUrl,
    this.lastMessage,
    this.metadata,
    this.name,
    required this.type,
    this.updatedAt,
    required this.users,
    this.userIds,
    this.userRoles
  });

  /// Creates room from a map (decoded JSON).
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Converts room to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  /// Creates a copy of the room with an updated data.
  /// [imageUrl], [name] and [updatedAt] with null values will nullify existing values
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [type] and [users] with null values will be overwritten by previous values.
  Room copyWith({
    String? id,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    String? name,
    RoomType? type,
    int? updatedAt,
    List<User>? users,
    List<String>? userIds,
    List<Map<String, String?>>? userRoles
  }) {
    return Room(
      id: id ?? this.id,
      imageUrl: imageUrl,
      lastMessage: lastMessage ?? '',
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      name: name,
      type: type ?? this.type,
      updatedAt: updatedAt,
      users: users ?? this.users,
      userIds: userIds ?? this.userIds,
      userRoles: userRoles ?? this.userRoles
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        createdAt,
        id,
        imageUrl,
        lastMessage,
        metadata,
        name,
        type,
        updatedAt,
        users,
        userIds,
        userRoles
      ];

  /// Created room timestamp, in ms
  final int? createdAt;

  /// Room's unique ID
  final String? id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? imageUrl;

  /// List of last messages this room has received
  final String? lastMessage;

  /// Additional custom metadata or attributes related to the room
  final Map<String, dynamic>? metadata;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// [RoomType]
  final RoomType? type;

  /// Updated room timestamp, in ms
  final int? updatedAt;

  /// List of users which are in the room
  final List<User>? users;

  /// List of user ids which are in the room
  final List<String>? userIds;

  /// List of user ids which are in the room
  final List<Map<String, String?>>? userRoles;
}
