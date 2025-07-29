import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_api_intern_project/models/users/user_model.dart';
import '../end_points.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  // ===== Users =====
  @GET(EndPoints.users)
  Future<UsersResponse> getUsers(@Header("Authorization") String token);

  @GET("${EndPoints.users}/{id}")
  Future<UserSingleResponse> getUserById(
      @Path("id") String id,
      @Header("Authorization") String token,
      );


  @POST(EndPoints.users)
  Future<User> createUser(
      @Body() User user,
      @Header("Authorization") String token,
      );

  @PUT("${EndPoints.users}/{id}")
  Future<User> updateUser(
      @Path("id") String id,
      @Body() Map<String, dynamic> user,
      @Header("Authorization") String token,
      );
  @DELETE("${EndPoints.users}/{id}")
  Future<void> deleteUser(
      @Path("id") String id,
      @Header("Authorization") String token,
      );
}
