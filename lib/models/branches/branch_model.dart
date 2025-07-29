import 'package:json_annotation/json_annotation.dart';

import '../markets/market_model.dart';

part 'branch_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchesResponse {
  final int results;
  final int total;
  final int page;
  final List<Branch> data;

  BranchesResponse({
    required this.results,
    required this.total,
    required this.page,
    required this.data,
  });

  factory BranchesResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BranchSingleResponse {
  final Branch data;

  BranchSingleResponse({required this.data});

  factory BranchSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSingleResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Branch {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String location;
  final Market marketId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  Branch({
    this.id,
    required this.name,
    required this.location,
    required this.marketId,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}