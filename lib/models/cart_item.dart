class CartItem {
  final String id; // use name as id for now
  final String name;
  final String description;
  final int price;
  final String icon;
  final String category;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.category,
    this.quantity = 1,
  });
}
