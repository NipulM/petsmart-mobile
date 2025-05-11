import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';

class CartService {
  static const String _cartKey = 'user_cart';

  Future<Cart> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson == null) {
      return Cart.empty();
    }
    try {
      return Cart.fromJson(json.decode(cartJson));
    } catch (e) {
      print('Error loading cart: $e');
      return Cart.empty();
    }
  }

  Future<void> saveCart(Cart cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, json.encode(cart.toJson()));
  }

  Future<void> addItem(CartItem item) async {
    final cart = await getCart();
    final updatedCart = cart.addItem(item);
    await saveCart(updatedCart);
  }

  Future<void> removeItem(String productId) async {
    final cart = await getCart();
    final updatedCart = cart.removeItem(productId);
    await saveCart(updatedCart);
  }

  Future<void> updateItemQuantity(String productId, int quantity) async {
    final cart = await getCart();
    final updatedCart = cart.updateItemQuantity(productId, quantity);
    await saveCart(updatedCart);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
