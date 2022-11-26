import 'package:auth_api/src/models/error_user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

/// The type definition for a JSON-serializable [Map].
typedef JsonUserMap = Map<String, dynamic>;

@immutable
@JsonSerializable()

///
class User extends Equatable {
  ///
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.emailVisibility,
    required this.verified,
    this.name,
    this.avatar,
  });

  ///
  UserStatus get status => UserStatus.active;

  ///
  final String id;

  ///
  final String? avatar;

  ///
  final String username;

  ///
  final String? name;

  ///
  final String email;

  ///
  final bool emailVisibility;

  ///
  final bool verified;

  @override
  List<Object?> get props => [id, email, username];

  ///
  User copyWith({
    String? id,
    String? avatar,
    String? username,
    String? name,
    String? email,
    bool? emailVisibility,
    bool? verified,
  }) {
    return User(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVisibility: emailVisibility ?? this.emailVisibility,
      verified: verified ?? this.verified,
    );
  }

  ///
  static User fromJson(JsonUserMap json) => _$UserFromJson(json);

  /// Converts this [User] into a [JsonUserMap].
  JsonUserMap toJson() => _$UserToJson(this);
}
