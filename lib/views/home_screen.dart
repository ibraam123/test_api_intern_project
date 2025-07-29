import 'package:flutter/material.dart';
import 'package:test_api_intern_project/models/tasks/task_model.dart';
import 'package:test_api_intern_project/repositories/task_repo.dart';
import 'package:test_api_intern_project/services/tasks_api_service/task_api.dart';
import 'package:test_api_intern_project/views/product_details.dart';

import '../helper_functions.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TaskRepo repo;
  late Future<TasksResponse> usersFuture;

  @override
  void initState() {
    super.initState();
    final dio = createDio();
    // Pass the Dio instance to TaskRepo
    repo = TaskRepo(TaskApiService(dio)); // Updated to use TaskRepo and TaskApiService
    usersFuture = repo.getTasks(); // Updated to fetch tasks
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
          IconButton(
            onPressed: () {
              setState(() {
                usersFuture = repo.getTasks(); // Updated to refresh tasks
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails( // Updated to navigate to TaskDetails
                          id: snapshot.data!.data![index].id!, // Assuming tasks also have an id
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text( // Displaying task id or other relevant task info
                          snapshot.data!.data![index].id!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          snapshot.data!.data![index].title!,
                          style: const TextStyle(
                            fontSize: 16,
                          )
                        ),
                        const SizedBox(height: 5),
                        Text(
                          snapshot.data!.data![index].description!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            );
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
