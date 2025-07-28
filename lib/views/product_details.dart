import 'package:flutter/material.dart';
import '../helper_functions.dart';
import '../models/products/product_model.dart';
import '../services/products_api_service/api_service.dart';
import '../services/products_api_service/product_repo.dart';

class ProductDetails extends StatefulWidget {
  final String id; // Changed to non-nullable
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late final ProductRepo repo;
  late Future<SingleProductResponse> productFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final dio = createDio();
    repo = ProductRepo(ProductApiService(dio));
    _loadProduct();
  }

  void _loadProduct() {
    setState((){
      try {
        productFuture = repo.getProductById(
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
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),
      body: FutureBuilder<SingleProductResponse>(
        future: productFuture,
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
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: _loadProduct,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('Product not found'));
          }

          final product = snapshot.data!.data;
          return SingleChildScrollView(
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
                        _buildInfoRow('Name', product.name ?? 'N/A'),
                        _buildInfoRow('Barcode', product.barcode ?? 'N/A'),
                        _buildInfoRow('Category', product.category ?? 'N/A'),
                        _buildInfoRow('Shelf', product.shelf ?? 'N/A'),
                        _buildInfoRow('Stock', product.stockQuantity?.toString() ?? 'N/A'),
                        _buildInfoRow('Status', product.availabilityStatus ?? 'N/A'),
                        if (product.addedBy != null) ...[
                          const Divider(),
                          const Text('Added By:', style: TextStyle(fontWeight: FontWeight.bold)),
                          _buildInfoRow('Name', product.addedBy!.name),
                          _buildInfoRow('Email', product.addedBy!.email),
                          _buildInfoRow('Role', product.addedBy!.role),
                        ],
                      ],
                    ),
                  ),
                ),
                ElevatedButton(onPressed:(){
                  repo.deleteProduct(product.id!);
                  Navigator.pop(context);
                } , child: Text("Delete"))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
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