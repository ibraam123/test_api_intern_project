import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsResponse {
  final int results;
  final int total;
  final int page;
  final List<Product> data;

  ProductsResponse({
    required this.results,
    required this.total,
    required this.page,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SingleProductResponse {
  final Product data;

  SingleProductResponse({required this.data});

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleProductResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? barcode;
  final String? category;
  final String? shelf;
  final int? stockQuantity;
  final String? availabilityStatus;
  final AddedBy? addedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  Product({
    this.id,
    this.name,
    this.barcode,
    this.category,
    this.shelf,
    this.stockQuantity,
    this.availabilityStatus,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddedBy {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String role;

  AddedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory AddedBy.fromJson(Map<String, dynamic> json) =>
      _$AddedByFromJson(json);

  Map<String, dynamic> toJson() => _$AddedByToJson(this);
}
