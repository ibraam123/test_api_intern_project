import 'package:dio/dio.dart';
import 'package:test_api_intern_project/services/tasks_api_service/task_api.dart';
import '../models/tasks/task_model.dart';
import 'market_repo.dart';

class TaskRepo {
  final TaskApiService taskApiService;
  final String token;

  TaskRepo(this.taskApiService)
      : token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDcxNmNjNzI5OTdhYzE4ZWEzMDgiLCJpYXQiOjE3NTM4MDQ5NDUsImV4cCI6MTc2MTU4MDk0NX0.9Em6wyUqXRdYnlNXSHCh2Us8cCeRsta9ikUACuxlXV4";

  Future<TasksResponse> getTasks() async {
    try {
      return await taskApiService.getTasks(token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch tasks');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch tasks');
    }
  }

  Future<TaskSingleResponse> getTaskById(String id) async {
    try {
      return await taskApiService.getTaskById(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch task by ID: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch task by ID: $id');
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      return await taskApiService.createTask(task, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to create task');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to create task');
    }
  }

  Future<Task> updateTask(String id, Map<String, dynamic> updateData) async {
    try {
      return await taskApiService.updateTask(id, updateData, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to update task: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to update task: $id');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await taskApiService.deleteTask(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to delete task: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to delete task: $id');
    }
  }

  Exception _handleDioError(DioException e, String defaultMessage) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final errorData = response?.data;

    print('''
    DioError occurred:
    URL: ${e.requestOptions.uri}
    Method: ${e.requestOptions.method}
    Status: $statusCode
    Error: ${errorData ?? e.message}
    ''');

    switch (statusCode) {
      case 400:
        return BadRequestException(errorData?['message'] ?? 'Invalid request');
      case 401:
        return UnauthorizedException('Please authenticate');
      case 403:
        return ForbiddenException('Operation not permitted');
      case 404:
        return NotFoundException('Task not found');
      case 422:
        return ValidationException(errorData?['errors'] ?? 'Validation failed');
      case 500:
        return ServerException('Server error occurred');
      default:
        return ApiException(errorData?['message'] ?? defaultMessage);
    }
  }

  Exception _handleGenericError(Object e, String defaultMessage) {
    print('Generic error occurred: $e');
    return ApiException(defaultMessage);
  }
}
