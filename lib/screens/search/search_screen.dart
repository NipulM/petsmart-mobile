import 'package:cb011999/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cb011999/services/product_service.dart';
import 'package:cb011999/services/category_service.dart';
import 'package:cb011999/models/category.dart';
import 'package:cb011999/screens/home/widgets/new_product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCategory;
  String? selectedPriceRange;
  List<Product> products = [];
  Map<String, int> categories = {};
  bool _isLoading = true;
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();

  // Price range options
  final Map<String, (String, String)> priceRanges = {
    '\$0 - \$9.99': ('0', '9.99'),
    '\$9.99 - \$19.00': ('9.99', '19.00'),
    '\$19.99 - \$49.00': ('19.99', '49.00'),
    '\$49.99 - \$99.00': ('49.99', '99.00'),
  };

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categoryList = await _categoryService.getAllCategories();
      setState(() {
        categories = {
          for (var category in categoryList) category.name: category.categoryId
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading categories: $e')),
      );
    }
  }

  void applyFilters() async {
    if (selectedCategory == null) return;

    try {
      String? minPrice;
      String? maxPrice;
      
      if (selectedPriceRange != null) {
        final (min, max) = priceRanges[selectedPriceRange]!;
        minPrice = min;
        maxPrice = max;
      }

      final filteredProducts = await _productService.getProductsByFilter(
        categories[selectedCategory].toString(),
        minPrice,
        maxPrice,
      );

      setState(() {
        products = filteredProducts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error filtering products: $e')),
      );
    }
  }

  void clearFilters() {
    setState(() {
      selectedCategory = null;
      selectedPriceRange = null;
      products = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    hint: Text('Pick an option'),
                    items: categories.keys.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Filter by Price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedPriceRange,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    hint: Text('Pick an option'),
                    items: priceRanges.keys.map((String range) {
                      return DropdownMenuItem(
                        value: range,
                        child: Text(range),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedPriceRange = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: applyFilters,
                          child: Text('Apply Filters'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: clearFilters,
                          child: Text('Clear Filters'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: products.isEmpty
                        ? Center(
                            child: Text(
                                'No products found. Try adjusting your filters.'),
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: NewProductItem(
                                  productName: product.name,
                                  productDescription: product.description,
                                  productShortDescription:
                                      product.shortDescription,
                                  productImage: product.imageUrl,
                                  productPrice: product.price,
                                  origin: 'search',
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
