// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponse _$ProductsResponseFromJson(Map<String, dynamic> json) =>
    ProductsResponse(
      results: (json['results'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total': instance.total,
      'page': instance.page,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

SingleProductResponse _$SingleProductResponseFromJson(
  Map<String, dynamic> json,
) => SingleProductResponse(
  data: Product.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SingleProductResponseToJson(
  SingleProductResponse instance,
) => <String, dynamic>{'data': instance.data.toJson()};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  barcode: json['barcode'] as String?,
  category: json['category'] as String?,
  shelf: json['shelf'] as String?,
  stockQuantity: (json['stockQuantity'] as num?)?.toInt(),
  availabilityStatus: json['availabilityStatus'] as String?,
  addedBy: json['addedBy'] == null
      ? null
      : AddedBy.fromJson(json['addedBy'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'barcode': instance.barcode,
  'category': instance.category,
  'shelf': instance.shelf,
  'stockQuantity': instance.stockQuantity,
  'availabilityStatus': instance.availabilityStatus,
  'addedBy': instance.addedBy?.toJson(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.version,
};

AddedBy _$AddedByFromJson(Map<String, dynamic> json) => AddedBy(
  id: json['_id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$AddedByToJson(AddedBy instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
};
