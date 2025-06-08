import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';
import '../services/token_service.dart';
import 'dart:convert';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final CartService _cartService = CartService();
  final TokenService _tokenService = TokenService();
  Cart? _cart;
  bool _isLoading = true;
  Map<String, dynamic>? _userData;
  String? _shippingLocation;

  @override
  void initState() {
    super.initState();
    _loadCartAndUserData();
  }

  Future<void> _loadCartAndUserData() async {
    try {
      // Load both cart and user data concurrently
      final futures = await Future.wait([
        _cartService.getCart(),
        _tokenService.getUserData(),
        _cartService.getCurrentLocationInfo(),
      ]);

      final cart = futures[0] as Cart;
      final userDataString = futures[1] as String?;
      final locationInfo = futures[2] as Map<String, dynamic>;

      setState(() {
        _cart = cart;
        // Format the shipping location
        _shippingLocation = '${locationInfo['displayName']}';
        if (userDataString != null) {
          // Convert the string format to proper JSON format
          // Remove the curly braces and split by comma
          final cleanedString =
              userDataString.substring(1, userDataString.length - 1);
          final pairs = cleanedString.split(', ');

          // Create a map from the key-value pairs
          _userData = {};
          for (var pair in pairs) {
            final keyValue = pair.split(': ');
            if (keyValue.length == 2) {
              var value = keyValue[1];
              // Handle null values
              if (value == 'null') {
                _userData![keyValue[0]] = null;
              } else {
                _userData![keyValue[0]] = value;
              }
            }
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateQuantity(String productId, int quantity) async {
    await _cartService.updateItemQuantity(productId, quantity);
    await _loadCartAndUserData();
  }

  Future<void> _removeItem(String productId) async {
    await _cartService.removeItem(productId);
    await _loadCartAndUserData();
  }

  Future<void> _checkout() async {
    final locationInfo = await _cartService.getCurrentLocationInfo();

    if (!_userData!.containsKey('name') ||
        !_userData!.containsKey('email') ||
        !_userData!.containsKey('phone') ||
        !_userData!.containsKey('address') ||
        _userData!['name'] == null ||
        _userData!['email'] == null ||
        _userData!['phone'] == null ||
        _userData!['address'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete your profile first')),
      );
      return;
    }

    await _cartService.checkout(
      _userData!['name'],
      _userData!['email'],
      _userData!['phone'],
      _userData!['address'],
    );
    await _loadCartAndUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cart == null || _cart!.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shopping Cart',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),

                  // Billing Information
                  if (_userData != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Billing Information',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text('Name: ${_userData!['name'] ?? 'N/A'}'),
                            Text('Email: ${_userData!['email'] ?? 'N/A'}'),
                            if (_userData!['phone'] != null)
                              Text('Phone: ${_userData!['phone']}'),
                            if (_userData!['address'] != null)
                              Text('Address: ${_userData!['address']}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Cart Items
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _cart!.items.length,
                    itemBuilder: (context, index) {
                      final item = _cart!.items[index];
                      return CartItemTile(
                        item: item,
                        onQuantityChanged: (quantity) =>
                            _updateQuantity(item.productId, quantity),
                        onRemove: () => _removeItem(item.productId),
                      );
                    },
                  ),

                  // Order Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal:'),
                              Text('\$${_cart!.total.toStringAsFixed(2)}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Shipping:'),
                                        const SizedBox(width: 8),
                                        const Text('FREE'),
                                      ],
                                    ),
                                    if (_shippingLocation != null) ...[
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              _shippingLocation!,
                                              style:
                                                  Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Update the address in userData
                                              setState(() {
                                                _userData!['address'] =
                                                    _shippingLocation;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Address updated successfully'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                            child: const Text('Use'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '\$${_cart!.total.toStringAsFixed(2)}',
                                style:
                                    Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Checkout Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => _checkout(),
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (item.quantity > 1) {
                      onQuantityChanged(item.quantity - 1);
                    }
                  },
                ),
                Text(
                  item.quantity.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => onQuantityChanged(item.quantity + 1),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
