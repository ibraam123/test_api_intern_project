import 'package:dio/dio.dart';
import 'package:test_api_intern_project/models/branches/branch_model.dart';
import '../services/branches_api_service/branch_api.dart';
import 'market_repo.dart';

class BranchRepo {
  final BranchApiService branchApiService;
  final String token;

  BranchRepo(this.branchApiService)
      : token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDcxNmNjNzI5OTdhYzE4ZWEzMDgiLCJpYXQiOjE3NTM4MDQ5NDUsImV4cCI6MTc2MTU4MDk0NX0.9Em6wyUqXRdYnlNXSHCh2Us8cCeRsta9ikUACuxlXV4";

  Future<BranchesResponse> getBranches() async {
    try {
      return await branchApiService.getBranches(token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch branches');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch branches');
    }
  }

  Future<BranchSingleResponse> getBranchById(String id) async {
    try {
      return await branchApiService.getBranchById(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch branch by ID: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch branch by ID: $id');
    }
  }

  Future<Branch> createBranch(Branch branch) async {
    try {
      return await branchApiService.createBranch(branch, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to create branch');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to create branch');
    }
  }

  Future<Branch> updateBranch(String id, Map<String, dynamic> updateData) async {
    try {
      return await branchApiService.updateBranch(id, updateData, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to update branch: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to update branch: $id');
    }
  }

  Future<void> deleteBranch(String id) async {
    try {
      await branchApiService.deleteBranch(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to delete branch: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to delete branch: $id');
    }
  }
  // Error handling helpers
  Exception _handleDioError(DioException e, String defaultMessage) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final errorData = response?.data;

    // Log the error for debugging
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
        return NotFoundException('Branch not found');
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
