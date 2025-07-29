import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UsersResponse {
  final int results;
  final PaginationResult paginationResult;
  final List<User> data;

  UsersResponse({
    required this.results,
    required this.paginationResult,
    required this.data,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserSingleResponse {
  final User data;

  UserSingleResponse({required this.data});

  factory UserSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSingleResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaginationResult {
  final int currentPage;
  final int limit;
  final int numberOfPages;

  PaginationResult({
    required this.currentPage,
    required this.limit,
    required this.numberOfPages,
  });

  factory PaginationResult.fromJson(Map<String, dynamic> json) =>
      _$PaginationResultFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? slug;
  final String? email;
  final String? phone;
  final String? password;
  final String? role;
  final String? branchId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  User({
    required this.id,
    required this.name,
    this.slug,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.branchId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}