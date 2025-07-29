import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_api_intern_project/models/products/product_model.dart';
import '../end_points.dart';

part 'product_api.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ProductApiService {
  factory ProductApiService(Dio dio, {String baseUrl}) = _ProductApiService;

  // ===== PRODUCTS =====
  @GET(EndPoints.products)
  Future<ProductsResponse> getProducts(@Header("Authorization") String token);

  @GET("${EndPoints.products}/{id}")
  Future<SingleProductResponse> getProductById(
    @Path("id") String id,
    @Header("Authorization") String token,
  );

  @GET("${EndPoints.products}/barcode/{barcode}")
  Future<SingleProductResponse> getProductByBarcode(
    @Path("barcode") String barcode,
    @Header("Authorization") String token,
  );

  @POST(EndPoints.products)
  Future<Product> createProduct(
    @Body() Product product,
    @Header("Authorization") String token,
  );

  @PUT("${EndPoints.products}/{id}")
  Future<Product> updateProduct(
    @Path("id") String id,
    @Body() Map<String, dynamic> product,
    @Header("Authorization") String token,
  );

  @DELETE("${EndPoints.products}/{id}")
  Future<void> deleteProduct(
    @Path("id") String id,
    @Header("Authorization") String token,
  );
}
