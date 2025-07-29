import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_api_intern_project/models/branches/branch_model.dart';
import '../end_points.dart';

part 'branch_api.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class BranchApiService {
  factory BranchApiService(Dio dio, {String baseUrl}) = _BranchApiService;

  // ===== Branches =====
  @GET(EndPoints.branches)
  Future<BranchesResponse> getBranches(@Header("Authorization") String token);

  @GET("${EndPoints.branches}/{id}")
  Future<BranchSingleResponse> getBranchById(
      @Path("id") String id,
      @Header("Authorization") String token,
      );


  @POST(EndPoints.branches)
  Future<Branch> createBranch(
      @Body() Branch branch,
      @Header("Authorization") String token,
      );

  @PUT("${EndPoints.branches}/{id}")
  Future<Branch> updateBranch(
      @Path("id") String id,
      @Body() Map<String, dynamic> branch,
      @Header("Authorization") String token,
      );

  @DELETE("${EndPoints.branches}/{id}")
  Future<void> deleteBranch(
      @Path("id") String id,
      @Header("Authorization") String token,
      );
}
