// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchesResponse _$BranchesResponseFromJson(Map<String, dynamic> json) =>
    BranchesResponse(
      results: (json['results'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchesResponseToJson(BranchesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total': instance.total,
      'page': instance.page,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

BranchSingleResponse _$BranchSingleResponseFromJson(
  Map<String, dynamic> json,
) => BranchSingleResponse(
  data: Branch.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BranchSingleResponseToJson(
  BranchSingleResponse instance,
) => <String, dynamic>{'data': instance.data.toJson()};

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
  id: json['_id'] as String?,
  name: json['name'] as String,
  location: json['location'] as String,
  marketId: Market.fromJson(json['marketId'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'location': instance.location,
  'marketId': instance.marketId.toJson(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.version,
};
