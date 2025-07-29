// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketsResponse _$MarketsResponseFromJson(Map<String, dynamic> json) =>
    MarketsResponse(
      results: (json['results'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Market.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketsResponseToJson(MarketsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total': instance.total,
      'page': instance.page,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

MarketsSingleResponse _$MarketsSingleResponseFromJson(
  Map<String, dynamic> json,
) => MarketsSingleResponse(
  data: Market.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MarketsSingleResponseToJson(
  MarketsSingleResponse instance,
) => <String, dynamic>{'data': instance.data.toJson()};

Market _$MarketFromJson(Map<String, dynamic> json) => Market(
  id: json['_id'] as String?,
  name: json['name'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.version,
};
