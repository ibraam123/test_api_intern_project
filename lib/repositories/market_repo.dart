import 'package:dio/dio.dart';
import 'package:test_api_intern_project/services/market_api_service/market_api.dart';
import '../../models/markets/market_model.dart';

class MarketRepo {
  final MarketApiService marketApiService;
  final String token;

  MarketRepo(this.marketApiService)
      : token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDcxNmNjNzI5OTdhYzE4ZWEzMDgiLCJpYXQiOjE3NTM4MDQ5NDUsImV4cCI6MTc2MTU4MDk0NX0.9Em6wyUqXRdYnlNXSHCh2Us8cCeRsta9ikUACuxlXV4";

  Future<MarketsResponse> getMarkets() async {
    try {
      return await marketApiService.getMarkets(token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch markets');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch markets');
    }
  }

  Future<MarketsSingleResponse> getMarketById(String id) async {
    try {
      return await marketApiService.getMarketById(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch market by ID: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch market by ID: $id');
    }
  }

  Future<Market> createMarket(Market market) async {
    try {
      return await marketApiService.createMarket(market, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to create market');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to create market');
    }
  }

  Future<Market> updateMarket(String id, Map<String, dynamic> updateData) async {
    try {
      return await marketApiService.updateMarket(id, updateData, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to update market: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to update market: $id');
    }
  }

  Future<void> deleteMarket(String id) async {
    try {
      await marketApiService.deleteMarket(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to delete market: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to delete market: $id');
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
        return NotFoundException('Market not found');
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

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class ValidationException extends ApiException {
  final dynamic errors;
  ValidationException(this.errors) : super('Validation failed');
}

class ServerException extends ApiException {
  ServerException(super.message);
}