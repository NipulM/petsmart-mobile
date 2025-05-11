import 'dart:convert';
import 'package:cb011999/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../services/token_service.dart';
import '../services/order_service.dart';
class CartService {
  static const String _cartKey = 'user_cart';
  final TokenService _tokenService = TokenService();
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

  Future<void> checkout(
      String name, String email, String phone_number, String address) async {
    final cart = await getCart();
    final userData = await _tokenService.getUserData();
    final order = Order(
      name: name,
      email: email,
      phone_number: phone_number,
      address: address,
      order_items: cart.items,
      total_amount: cart.total,
      status: "pending",
      created_at: DateTime.now().toIso8601String(),
      delivered_at: null,
    );

    print(order);
    final orderService = OrderService();
    await orderService.createOrder(order);
  }
}
