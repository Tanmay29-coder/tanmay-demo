import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  int get subtotal {
    return _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get deliveryFee {
    return subtotal > 300 ? 0 : 40;
  }

  int get total {
    return subtotal + (subtotal > 0 ? deliveryFee : 0);
  }

  void addItem({
    required String id,
    required String name,
    required String description,
    required int price,
    required String icon,
    required String category,
  }) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          description: existingItem.description,
          price: existingItem.price,
          icon: existingItem.icon,
          category: existingItem.category,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          name: name,
          description: description,
          price: price,
          icon: icon,
          category: category,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (!_items.containsKey(id)) return;

    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          description: existingItem.description,
          price: existingItem.price,
          icon: existingItem.icon,
          category: existingItem.category,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
