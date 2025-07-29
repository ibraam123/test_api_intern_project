import 'package:dio/dio.dart';
import 'package:test_api_intern_project/models/users/user_model.dart';
import '../services/users_api_service/user_api.dart';
import 'market_repo.dart';

class UserRepo {
  final UserApiService userApiService;
  final String token;

  UserRepo(this.userApiService)
      : token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDcxNmNjNzI5OTdhYzE4ZWEzMDgiLCJpYXQiOjE3NTM4MDQ5NDUsImV4cCI6MTc2MTU4MDk0NX0.9Em6wyUqXRdYnlNXSHCh2Us8cCeRsta9ikUACuxlXV4";

  Future<UsersResponse> getUsers() async {
    try {
      return await userApiService.getUsers(token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch users');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch users');
    }
  }

  Future<UserSingleResponse> getUserById(String id) async {
    try {
      return await userApiService.getUserById(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch user by ID: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch user by ID: $id');
    }
  }

  Future<User> createUser(User user) async {
    try {
      return await userApiService.createUser(user, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to create user');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to create user');
    }
  }

  Future<User> updateUser(String id, Map<String, dynamic> updateData) async {
    try {
      return await userApiService.updateUser(id, updateData, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to update user: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to update user: $id');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await userApiService.deleteUser(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to delete user: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to delete user: $id');
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
        return ForbiddenException('Operation not permitted for this user');
      case 404:
        return NotFoundException('User not found');
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

