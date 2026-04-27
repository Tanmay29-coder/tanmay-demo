import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../orders/order_tracking_screen.dart';
import '../payment/payment_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final _cartItems = cartProvider.items;
    final _totalItems = cartProvider.itemCount;
    final _subtotal = cartProvider.subtotal;
    final _deliveryFee = cartProvider.deliveryFee;
    final _total = cartProvider.total;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                cartProvider.clear();
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._cartItems.entries.map((entry) {
                  return _buildCartItem(context, entry.key);
                }).toList(),
                const SizedBox(height: 16),
                _buildDeliveryInfo(_deliveryFee, _subtotal),
                const SizedBox(height: 16),
                _buildPriceSummary(_totalItems, _subtotal, _deliveryFee, _total),
              ],
            ),
          ),
          _buildCheckoutButton(_total),
        ],
      ),
    );
  }


  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items from a restaurant to get started',
            style: TextStyle(color: AppColors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
            ),
            child: const Text('Browse Restaurants'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, String itemId) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final item = cartProvider.items[itemId]!;
    
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                item.icon,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.price} each',
                  style: const TextStyle(

                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => cartProvider.removeItem(item.id),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.remove,
                      color: AppColors.black, size: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cartProvider.addItem(
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    price: item.price,
                    icon: item.icon,
                    category: item.category,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add,
                      color: AppColors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Text(
            '₹${item.price * item.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(int _deliveryFee, int _subtotal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.success.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.delivery_dining,
              color: AppColors.success, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _deliveryFee == 0
                  ? '🎉 You got free delivery!'
                  : 'Add ₹${300 - _subtotal} more for free delivery',
              style: const TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(int _totalItems, int _subtotal, int _deliveryFee, int _total) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          _buildPriceRow('Subtotal ($_totalItems items)', '₹$_subtotal'),
          const SizedBox(height: 8),
          _buildPriceRow(
            'Delivery Fee',
            _deliveryFee == 0 ? 'FREE' : '₹$_deliveryFee',
            valueColor:
            _deliveryFee == 0 ? AppColors.success : AppColors.black,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _buildPriceRow(
            'Total',
            '₹$_total',
            isBold: true,
            valueColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      String label,
      String value, {
        bool isBold = false,
        Color valueColor = AppColors.black,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? AppColors.black : AppColors.grey,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(int _total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentScreen(totalAmount: _total),
            ),
          );
        },
        child: Text(
          'Proceed to Checkout  •  ₹$_total',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}