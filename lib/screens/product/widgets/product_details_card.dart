// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/product/widgets/price_and_quantity_section.dart';
import 'package:cb011999/widgets/button.dart';
import 'package:cb011999/widgets/cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../models/cart_item.dart';
import '../../../services/cart_service.dart';
import '../../../widgets/add_cart_button.dart';
import '../../../models/favorite.dart';
import '../../../services/favorite_service.dart';

class ProductDetailsCard extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  const ProductDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  final CartService _cartService = CartService();
  final FavoriteService _favoriteService = FavoriteService();
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await _favoriteService.isProductFavorite(
      widget.title.toLowerCase().replaceAll(' ', '_'),
    );
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      final favorite = Favorite(
        productId: widget.title.toLowerCase().replaceAll(' ', '_'),
        name: widget.title,
        price: widget.price,
        imageUrl: widget.imageUrl,
        category: widget.category,
        description: widget.description,
      );

      await _favoriteService.toggleFavorite(favorite);
      
      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating favorites: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _updateQuantity(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  Future<void> _addToCart() async {
    try {
      final cartItem = CartItem(
        productId: widget.title.toLowerCase().replaceAll(' ', '_'),
        name: widget.title,
        price: widget.price,
        quantity: _quantity,
        imageUrl: widget.imageUrl,
      );

      await _cartService.addItem(cartItem);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added to cart'),
            duration: Duration(seconds: 1),
          ),
        );

        // Show cart bottom sheet
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: const CartBottomSheet(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding to cart: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto Bold',
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : (isDarkMode ? Colors.white : Colors.black),
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
          Text(
            "#${widget.category}",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.description,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          PriceAndQuantitySection(
            price: widget.price.toString(),
            onQuantityChanged: _updateQuantity,
          ),
          const SizedBox(height: 20),
          AddCartButton(
            buttonText: "Add to Cart",
            onPressed: _addToCart,
          ),
        ],
      ),
    );
  }
}
