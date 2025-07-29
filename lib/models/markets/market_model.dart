import 'package:json_annotation/json_annotation.dart';

part 'market_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MarketsResponse {
  final int results;
  final int total;
  final int page;
  final List<Market> data;

  MarketsResponse({
    required this.results,
    required this.total,
    required this.page,
    required this.data,
  });

  factory MarketsResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketsResponseToJson(this);

}

@JsonSerializable(explicitToJson: true)
class MarketsSingleResponse {
  final Market data;

  MarketsSingleResponse({required this.data});

  factory MarketsSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketsSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketsSingleResponseToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Market {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  Market({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Market.fromJson(Map<String, dynamic> json) =>
      _$MarketFromJson(json);

  Map<String, dynamic> toJson() => _$MarketToJson(this);
}
