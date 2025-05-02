// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/models/product.dart';
import 'package:cb011999/screens/home/widgets/new_product_item.dart';
import 'package:cb011999/services/product_service.dart';
import 'package:flutter/material.dart';

class NewProductsSection extends StatefulWidget {
  const NewProductsSection({super.key});

  @override
  State<NewProductsSection> createState() => _NewProductsSectionState();
}

class _NewProductsSectionState extends State<NewProductsSection> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.getAllProducts();
      setState(() {
        _products = products.where((p) => p.isNew).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Text(
                          'Error loading products: $_error',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : _products.isEmpty
                        ? const Center(
                            child: Text('No new products available'),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: NewProductItem(
                                  productName: product.name,
                                  productShortDescription:
                                      product.shortDescription,
                                  productImage: product.imageUrl,
                                  productPrice: product.price,
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
