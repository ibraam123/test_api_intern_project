import 'package:flutter/material.dart';
import 'package:test_api_intern_project/models/products/product_model.dart';
import 'package:test_api_intern_project/views/product_details.dart';

import '../helper_functions.dart';
import '../services/products_api_service/api_service.dart';
import '../services/products_api_service/product_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductRepo repo;
  late Future<ProductsResponse> usersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dio = createDio();
    repo = ProductRepo(ProductApiService(dio));
    usersFuture = repo.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    Product product = Product(
      name: "kokoko magdy",
      barcode: "464648798",
      category: "Beverages",
      shelf: "A1-B2",
      stockQuantity: 20,
      availabilityStatus: "high",
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              repo.createProduct(product);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
          IconButton(
            onPressed: () {
              setState(() {
                usersFuture = repo.getProducts();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: usersFuture,
        builder: (snapshot, usersFuture) {
          if (usersFuture.hasData) {
            return ListView.builder(
              itemCount: usersFuture.data!.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          id: usersFuture.data!.data[index].id!,
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
                        Text(usersFuture.data!.data[index].name!),
                        Text(usersFuture.data!.data[index].category!),
                        Text(usersFuture.data!.data[index].shelf!),
                        Text(
                          usersFuture.data!.data[index].stockQuantity
                              .toString(),
                        ),
                        Text(usersFuture.data!.data[index].availabilityStatus!),
                      ],
                    ),
                  ),
                );
              },
            );
          }else if(usersFuture.hasError){
            return Center(child: Text(usersFuture.error.toString()));
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
