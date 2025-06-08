import 'dart:convert';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:cb011999/models/order.dart';
import 'package:cb011999/models/order_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../services/token_service.dart';
import '../services/order_service.dart';

class CartService {
  static const String _cartKey = 'user_cart';
  final TokenService _tokenService = TokenService();
  final Location location = Location();

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

  Future<Map<String, dynamic>> getCurrentLocationInfo() async {
    try {
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          throw Exception('Location services are disabled.');
        }
      }

      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          throw Exception('Location permissions are denied');
        }
      }

      LocationData _locationData = await location.getLocation();

      var uri = Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=${_locationData.latitude}&lon=${_locationData.longitude}&zoom=18&addressdetails=1");

      var response = await http.get(uri, headers: {
        'User-Agent': 'Petsmart', // Required by Nominatim
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var address = decodedData['address'];

        print("======================");
        print({
          'latitude': _locationData.latitude,
          'longitude': _locationData.longitude,
          'displayName': decodedData['display_name'],
          'city': address['city'] ?? address['town'] ?? address['village'],
          'state': address['state'],
          'country': address['country'],
          'countryCode': address['country_code'],
          'postcode': address['postcode'],
          'road': address['road'],
          'suburb': address['suburb'],
        });
        print("======================");

        return {
          'latitude': _locationData.latitude,
          'longitude': _locationData.longitude,
          'displayName': decodedData['display_name'],
          'city': address['city'] ?? address['town'] ?? address['village'],
          'state': address['state'],
          'country': address['country'],
          'countryCode': address['country_code'],
          'postcode': address['postcode'],
          'road': address['road'],
          'suburb': address['suburb'],
        };
      } else {
        throw Exception('Failed to get location info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting location info: $e');
      rethrow;
    }
  }

  String? _getCountryCode(List addressComponents) {
    for (var component in addressComponents) {
      if (component['types'].contains('country')) {
        return component['short_name'];
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> _getWeatherLocationInfo(
      LocationData locationData) async {
    // Your existing OpenWeatherMap code as fallback
    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=158361e56f89385856d40093de91ffd1");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return {
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'city': decodedData['name'],
        'country': decodedData['sys']['country'],
      };
    } else {
      throw Exception('Failed to get location info: ${response.statusCode}');
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

    // Convert CartItem list to OrderItem list
    final orderItems = cart.items
        .map((cartItem) => OrderItem(
              productId: cartItem.productId,
              name: cartItem.name,
              price: cartItem.price,
              quantity: cartItem.quantity,
              imageUrl: cartItem.imageUrl,
            ))
        .toList();

    final order = Order(
      name: name,
      email: email,
      phone_number: phone_number,
      address: address,
      order_items: orderItems,
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
