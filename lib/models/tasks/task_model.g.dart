// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksResponse _$TasksResponseFromJson(Map<String, dynamic> json) =>
    TasksResponse(
      results: (json['results'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksResponseToJson(TasksResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total': instance.total,
      'page': instance.page,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

TaskSingleResponse _$TaskSingleResponseFromJson(Map<String, dynamic> json) =>
    TaskSingleResponse(
      data: Task.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskSingleResponseToJson(TaskSingleResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String?,
  branchId: json['branchId'] == null
      ? null
      : Branch.fromJson(json['branchId'] as Map<String, dynamic>),
  marketId: json['marketId'] == null
      ? null
      : Market.fromJson(json['marketId'] as Map<String, dynamic>),
  createdBy: json['createdBy'] as Map<String, dynamic>?,
  assignedTo: json['assignedTo'] as Map<String, dynamic>?,
  status: json['status'] as String?,
  scheduledDate: json['scheduledDate'] == null
      ? null
      : DateTime.parse(json['scheduledDate'] as String),
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'branchId': instance.branchId?.toJson(),
  'marketId': instance.marketId?.toJson(),
  'createdBy': instance.createdBy,
  'assignedTo': instance.assignedTo,
  'status': instance.status,
  'scheduledDate': instance.scheduledDate?.toIso8601String(),
  'attachments': instance.attachments,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.version,
};

TaskAnalyticsResponse _$TaskAnalyticsResponseFromJson(
  Map<String, dynamic> json,
) => TaskAnalyticsResponse(
  data: TaskAnalyticsData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaskAnalyticsResponseToJson(
  TaskAnalyticsResponse instance,
) => <String, dynamic>{'data': instance.data.toJson()};

TaskAnalyticsData _$TaskAnalyticsDataFromJson(Map<String, dynamic> json) =>
    TaskAnalyticsData(
      statusAnalytics: (json['statusAnalytics'] as List<dynamic>)
          .map((e) => AnalyticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeAnalytics: (json['typeAnalytics'] as List<dynamic>)
          .map((e) => AnalyticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskAnalyticsDataToJson(
  TaskAnalyticsData instance,
) => <String, dynamic>{
  'statusAnalytics': instance.statusAnalytics.map((e) => e.toJson()).toList(),
  'typeAnalytics': instance.typeAnalytics.map((e) => e.toJson()).toList(),
};

AnalyticsItem _$AnalyticsItemFromJson(Map<String, dynamic> json) =>
    AnalyticsItem(
      id: json['_id'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyticsItemToJson(AnalyticsItem instance) =>
    <String, dynamic>{'_id': instance.id, 'count': instance.count};
