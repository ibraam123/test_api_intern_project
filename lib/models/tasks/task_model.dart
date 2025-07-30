import 'package:json_annotation/json_annotation.dart';
import '../branches/branch_model.dart';
import '../markets/market_model.dart';
part 'task_model.g.dart'; // Fixed typo in filename (was 'tasl_model.g.dart')

@JsonSerializable(explicitToJson: true)
class TasksResponse {
  final int results;
  final int total;
  final int page;
  final List<Task> data;

  TasksResponse({
    required this.results,
    required this.total,
    required this.page,
    required this.data,
  });

  factory TasksResponse.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TasksResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TaskSingleResponse {
  final Task data;

  TaskSingleResponse({required this.data});

  factory TaskSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskSingleResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Task {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final Branch? branchId;
  final Market? marketId;

  final Map<String, dynamic>? createdBy;
  final Map<String, dynamic>? assignedTo;

  final String? status;
  final DateTime? scheduledDate;
  final List<String>? attachments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  Task({
    this.id,
    this.title,
    this.description,
    this.type,
    this.branchId,
    this.marketId,
    this.createdBy,
    this.assignedTo,
    this.status,
    this.scheduledDate,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TaskAnalyticsResponse {
  final TaskAnalyticsData data;

  TaskAnalyticsResponse({required this.data});

  factory TaskAnalyticsResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskAnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskAnalyticsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TaskAnalyticsData {
  final List<AnalyticsItem> statusAnalytics;
  final List<AnalyticsItem> typeAnalytics;

  TaskAnalyticsData({
    required this.statusAnalytics,
    required this.typeAnalytics,
  });

  factory TaskAnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$TaskAnalyticsDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaskAnalyticsDataToJson(this);
}

@JsonSerializable()
class AnalyticsItem {
  @JsonKey(name: '_id')
  final String id;
  final int count;

  AnalyticsItem({
    required this.id,
    required this.count,
  });

  factory AnalyticsItem.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsItemToJson(this);
}