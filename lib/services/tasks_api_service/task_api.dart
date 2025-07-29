import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:test_api_intern_project/models/tasks/task_model.dart';
import '../end_points.dart';

part 'task_api.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class TaskApiService {
  factory TaskApiService(Dio dio, {String baseUrl}) = _TaskApiService;

  // ===== Tasks =====
  @GET(EndPoints.tasks)
  Future<TasksResponse> getTasks(@Header("Authorization") String token);

  @GET("${EndPoints.tasks}/{id}")
  Future<TaskSingleResponse> getTaskById(
    @Path("id") String id,
    @Header("Authorization") String token,
  );

  @GET("${EndPoints.tasks}/analytics")
  Future<TaskAnalyticsResponse> getTaskAnalytics(
    @Header("Authorization") String token,
  );

  @POST(EndPoints.tasks)
  Future<Task> createTask(
    @Body() Task task,
    @Header("Authorization") String token,
  );

  @PUT("${EndPoints.tasks}/{id}")
  Future<Task> updateTask(
    @Path("id") String id,
    @Body() Map<String, dynamic> task,
    @Header("Authorization") String token,
  );

  @DELETE("${EndPoints.tasks}/{id}")
  Future<void> deleteTask(
    @Path("id") String id,
    @Header("Authorization") String token,
  );
}
