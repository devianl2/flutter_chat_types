import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// All possible roles user can have.
enum Role { moderator, learner }

/// A class that represents user.
@JsonSerializable()
@immutable
class User extends Equatable {
  /// Creates a user.
  const User({
    required this.uid,
    this.tenantId,
    this.staffId,
    this.displayName,
    this.email,
    this.imageUrl,
    this.metadata,
    this.role,
    this.createdAt,
    this.createdAtString
  });

  /// Creates user from a map (decoded JSON).
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts user to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Creates a copy of the user with an updated data.
  /// [uid], [tenantId], [staffId], [displayName], [email], [imageUrl], [role] and [createdAt]
  /// with null values will nullify existing values.
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  User copyWith({
    String? uid,
    String? tenantId,
    String? staffId,
    String? displayName,
    String? email,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    Role? role,
    int? createdAt,
    String? createdAtString,
  }) {
    return User(
      uid: uid,
      tenantId: tenantId,
      staffId: staffId,
      displayName: displayName,
      email: email,
      imageUrl: imageUrl,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      role: role,
      createdAt: createdAt,
      createdAtString: createdAtString,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        uid,
        tenantId,
        staffId,
        displayName,
        email,
        imageUrl,
        metadata,
        role,
        createdAt,
        createdAtString
      ];

  /// Unique ID of the user
  final String? uid;

  /// Tenant ID of the user
  final String? tenantId;

  /// Staff ID of the user
  final String? staffId;

  /// Display name of the user
  final String? displayName;

  /// Email of the user
  final String? email;

  /// Remote image URL representing user's avatar
  final String? imageUrl;

  /// Additional custom metadata or attributes related to the user
  final Map<String, dynamic>? metadata;

  /// User [Role]
  final Role? role;

  /// Created user timestamp, in ms
  final int? createdAt;

  /// Created user timestamp, in iso8601
  final String? createdAtString;
}
