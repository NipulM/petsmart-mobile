import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart({
    required this.items,
  });

  double get total => items.fold(0, (sum, item) => sum + item.total);

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  factory Cart.empty() {
    return Cart(items: []);
  }

  Cart addItem(CartItem newItem) {
    final existingItemIndex =
        items.indexWhere((i) => i.productId == newItem.productId);

    if (existingItemIndex != -1) {
      // Get the existing item
      final existingItem = items[existingItemIndex];
      // Create a new item with combined quantity
      final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + newItem.quantity);

      final updatedItems = List<CartItem>.from(items);
      updatedItems[existingItemIndex] = updatedItem;
      return Cart(items: updatedItems);
    } else {
      return Cart(items: [...items, newItem]);
    }
  }

  Cart removeItem(String productId) {
    return Cart(
      items: items.where((item) => item.productId != productId).toList(),
    );
  }

  Cart updateItemQuantity(String productId, int quantity) {
    return Cart(
      items: items.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList(),
    );
  }

  Cart clear() {
    return Cart.empty();
  }
}
