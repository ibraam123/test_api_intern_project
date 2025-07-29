import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_api_intern_project/models/markets/market_model.dart';
import '../end_points.dart';

part 'market_api.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class MarketApiService {
  factory MarketApiService(Dio dio, {String baseUrl}) = _MarketApiService;

  // ===== Markets =====
  @GET(EndPoints.markets)
  Future<MarketsResponse> getMarkets(@Header("Authorization") String token);

  @GET("${EndPoints.markets}/{id}")
  Future<MarketsSingleResponse> getMarketById(
      @Path("id") String id,
      @Header("Authorization") String token,
      );


  @POST(EndPoints.markets)
  Future<Market> createMarket(
      @Body() Market market,
      @Header("Authorization") String token,
      );

  @PUT("${EndPoints.markets}/{id}")
  Future<Market> updateMarket(
      @Path("id") String id,
      @Body() Map<String, dynamic> market,
      @Header("Authorization") String token,
      );

  @DELETE("${EndPoints.markets}/{id}")
  Future<void> deleteMarket(
      @Path("id") String id,
      @Header("Authorization") String token,
      );
}
