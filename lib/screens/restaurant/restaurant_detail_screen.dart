import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_screen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String name;
  final String cuisine;
  final String rating;
  final String time;
  final String icon;
  final Color color;

  const RestaurantDetailScreen({
    super.key,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  State<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {

  final List<Map<String, dynamic>> _menuItems = [
    {
      'name': 'Classic Margherita',
      'description': 'Fresh tomatoes, mozzarella, basil',
      'price': 299,
      'icon': '🍕',
      'category': 'Popular',
    },
    {
      'name': 'Pepperoni Special',
      'description': 'Loaded with pepperoni and cheese',
      'price': 399,
      'icon': '🍕',
      'category': 'Popular',
    },
    {
      'name': 'BBQ Chicken',
      'description': 'Grilled chicken with BBQ sauce',
      'price': 449,
      'icon': '🍗',
      'category': 'Recommended',
    },
    {
      'name': 'Veggie Delight',
      'description': 'Fresh veggies on tomato base',
      'price': 249,
      'icon': '🥗',
      'category': 'Recommended',
    },
    {
      'name': 'Garlic Bread',
      'description': 'Crispy garlic bread with butter',
      'price': 99,
      'icon': '🥖',
      'category': 'Sides',
    },
    {
      'name': 'Coca Cola',
      'description': 'Chilled 330ml can',
      'price': 60,
      'icon': '🥤',
      'category': 'Drinks',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final _totalItems = cartProvider.itemCount;
    final _totalPrice = cartProvider.subtotal;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRestaurantInfo(),
                _buildMenuList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _totalItems > 0 ? _buildCartBar(_totalItems, _totalPrice) : null,
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.black, size: 18),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.black),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: widget.color,
          child: Center(
            child: Text(
              widget.icon,
              style: const TextStyle(fontSize: 80),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.cuisine,
            style: const TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(Icons.star, widget.rating, AppColors.success),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.access_time, widget.time, AppColors.primary),
              const SizedBox(width: 12),
              _buildInfoChip(
                  Icons.delivery_dining, 'Free delivery', AppColors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    final categories =
    _menuItems.map((e) => e['category'] as String).toSet().toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) {
          final items =
          _menuItems.where((e) => e['category'] == category).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              ...items.map((item) => _buildMenuItem(item)).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    final cartProvider = Provider.of<CartProvider>(context);
    final quantity = cartProvider.items[item['name']]?.quantity ?? 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                item['icon'] as String,
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'] as String,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${item['price']}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          quantity == 0
              ? GestureDetector(
            onTap: () {
              cartProvider.addItem(
                id: item['name'] as String,
                name: item['name'] as String,
                description: item['description'] as String,
                price: item['price'] as int,
                icon: item['icon'] as String,
                category: item['category'] as String,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add,
                  color: AppColors.white, size: 20),
            ),
          )
              : Row(
            children: [
              GestureDetector(
                onTap: () => cartProvider.removeItem(item['name'] as String),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.remove,
                      color: AppColors.black, size: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cartProvider.addItem(
                    id: item['name'] as String,
                    name: item['name'] as String,
                    description: item['description'] as String,
                    price: item['price'] as int,
                    icon: item['icon'] as String,
                    category: item['category'] as String,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add,
                      color: AppColors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartBar(int totalItems, int totalPrice) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CartScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$totalItems items',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'View Cart',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '₹$totalPrice',
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}