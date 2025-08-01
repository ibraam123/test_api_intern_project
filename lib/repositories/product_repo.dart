import 'package:dio/dio.dart';
import 'package:test_api_intern_project/services/products_api_service/product_api.dart';
import '../models/products/product_model.dart';
import 'market_repo.dart';

class ProductRepo {
  final ProductApiService productApiService;
  final String token;

  ProductRepo(this.productApiService)
      : token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODYzZDcxNmNjNzI5OTdhYzE4ZWEzMDgiLCJpYXQiOjE3NTM4MDQ5NDUsImV4cCI6MTc2MTU4MDk0NX0.9Em6wyUqXRdYnlNXSHCh2Us8cCeRsta9ikUACuxlXV4";

  Future<ProductsResponse> getProducts() async {
    try {
      return await productApiService.getProducts(token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch products');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch products');
    }
  }

  Future<SingleProductResponse> getProductById(String id) async {
    try {
      return await productApiService.getProductById(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch product by ID: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch product by ID: $id');
    }
  }

  Future<SingleProductResponse> getProductByBarcode(String barcode) async {
    try {
      return await productApiService.getProductByBarcode(barcode, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch product by barcode: $barcode');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to fetch product by barcode: $barcode');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      return await productApiService.createProduct(product, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to create product');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to create product');
    }
  }

  Future<Product> updateProduct(String id, Map<String, dynamic> updateData) async {
    try {
      return await productApiService.updateProduct(id, updateData, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to update product: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to update product: $id');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await productApiService.deleteProduct(id, token);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to delete product: $id');
    } catch (e) {
      throw _handleGenericError(e, 'Failed to delete product: $id');
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
        return NotFoundException('Product not found');
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

