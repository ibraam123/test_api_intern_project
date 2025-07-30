import 'package:flutter/material.dart';
import 'package:test_api_intern_project/repositories/task_repo.dart';
import 'package:test_api_intern_project/helper_functions.dart';
import 'package:test_api_intern_project/repositories/market_repo.dart';

import '../models/tasks/task_model.dart';
import '../services/tasks_api_service/task_api.dart';

class ProductDetails extends StatefulWidget {
  final String id; // Changed to non-nullable
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late final TaskRepo repo;
  late Future<TaskSingleResponse> taskFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final dio = createDio();
    repo = TaskRepo(TaskApiService(dio));
    _loadProduct();
  }

  void _loadProduct() {
    setState((){
      try {
        taskFuture = repo.getTaskById(
          widget.id,
        );
        // Handle successful response
      } on NotFoundException {
        showErrorSnackbar('Product not found');
      } on UnauthorizedException {
        showErrorSnackbar('Unauthorized');
      } on ServerException {
        showErrorSnackbar('Server error occurred');
      } on ApiException catch (e) {
        showErrorSnackbar(e.message);
      } catch (e) {
        showErrorSnackbar('An unexpected error occurred');
      }
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details"), centerTitle: true),
      body: FutureBuilder<TaskSingleResponse>(
        future: taskFuture,
        builder: (context, snapshot) {
          if (_isLoading && snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load product'),
                  Text('Error: ${snapshot.error.toString()}'),
                  ElevatedButton(
                    onPressed: _loadProduct,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('Task not found'));
          }

          final task = snapshot.data!.data;
          return GestureDetector(
            onTap: () {
              repo.updateTask(
                task.id!,
                {
                  "title": "Updated Task Title",
                },
              );
              Navigator.pop(context);
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            task.description!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Status: ${task.status ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Type: ${task.type ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Branch: ${task.branchId?.name ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Market: ${task.marketId?.name ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Created By: ${task.createdBy?['name'] ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Assigned To: ${task.assignedTo?['name'] ?? 'Not set'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showErrorSnackbar(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}