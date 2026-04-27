import '../profile/profile_screen.dart';
import '../restaurant/restaurant_detail_screen.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String userName = "Tanmay";

  final List<Map<String, dynamic>> _categories = [
    {'icon': '🍕', 'name': 'Pizza'},
    {'icon': '🍔', 'name': 'Burger'},
    {'icon': '🍣', 'name': 'Sushi'},
    {'icon': '🍜', 'name': 'Noodles'},
    {'icon': '🌮', 'name': 'Tacos'},
    {'icon': '🍰', 'name': 'Dessert'},
    {'icon': '🥗', 'name': 'Healthy'},
    {'icon': '🥐', 'name': 'Bakery'},
    {'icon': '☕', 'name': 'Cafe'},
  ];

  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Pizza Palace',
      'cuisine': 'Italian • Pizza',
      'rating': '4.8',
      'time': '20-30 min',
      'delivery': 'Free delivery',
      'color': Color(0xFFFFE0E0),
      'icon': '🍕',
    },
    {
      'name': 'Burger Barn',
      'cuisine': 'American • Burgers',
      'rating': '4.5',
      'time': '15-25 min',
      'delivery': '₹20 delivery',
      'color': Color(0xFFFFEDD5),
      'icon': '🍔',
    },
    {
      'name': 'Sushi World',
      'cuisine': 'Japanese • Sushi',
      'rating': '4.9',
      'time': '30-40 min',
      'delivery': 'Free delivery',
      'color': Color(0xFFE0F0FF),
      'icon': '🍣',
    },
    {
      'name': 'Noodle House',
      'cuisine': 'Chinese • Noodles',
      'rating': '4.6',
      'time': '20-35 min',
      'delivery': '₹15 delivery',
      'color': Color(0xFFE8FFE0),
      'icon': '🍜',
    },
    {
      'name': 'Mexican Grill',
      'cuisine': 'Mexican • Tacos',
      'rating': '4.7',
      'time': '25-40 min',
      'delivery': '₹25 delivery',
      'color': Color(0xFFFFF0D4),
      'icon': '🌮',
    },
    {
      'name': 'Sweet Treats',
      'cuisine': 'Desserts • Cakes',
      'rating': '4.8',
      'time': '15-20 min',
      'delivery': 'Free delivery',
      'color': Color(0xFFFFE4F2),
      'icon': '🍰',
    },
    {
      'name': 'Healthy Bites',
      'cuisine': 'Salads • Healthy',
      'rating': '4.6',
      'time': '20-30 min',
      'delivery': '₹10 delivery',
      'color': Color(0xFFE5FFED),
      'icon': '🥗',
    },
    {
      'name': 'Cafe Mocha',
      'cuisine': 'Coffee • Bakery',
      'rating': '4.9',
      'time': '10-20 min',
      'delivery': 'Free delivery',
      'color': Color(0xFFF3E5F5),
      'icon': '☕',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return const SearchScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      case 0:
      default:
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildBanner(),
                _buildCategories(),
                _buildRestaurantList(),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on, color: AppColors.primary, size: 18),
                  SizedBox(width: 4),
                  Text(
                    'Mumbai, India',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Hello, $userName 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Notifications'),
                  content: const Text('You have no new notifications right now.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      color: AppColors.black),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'What are you craving today?',
            hintStyle: const TextStyle(color: AppColors.grey, fontSize: 15),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.search, color: AppColors.primary, size: 26),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.tune, color: AppColors.white, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF4081)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3)),
                      ),
                      child: const Text(
                        '🌟 Exclusive Deal',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Get 30% OFF\non your first feast!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Text(
                        'Claim Now',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            right: -20,
            bottom: -20,
            child: Text('🍔', style: TextStyle(fontSize: 110)),
          ),
          const Positioned(
            right: 50,
            top: -30,
            child: Text('✨', style: TextStyle(fontSize: 40)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 16, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.white, Color(0xFFFFF5F0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.12),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.15),
                            width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index]['icon'],
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _categories[index]['name'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = _restaurants[index];
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(
                        name: restaurant['name'] as String,
                        cuisine: restaurant['cuisine'] as String,
                        rating: restaurant['rating'] as String,
                        time: restaurant['time'] as String,
                        icon: restaurant['icon'] as String,
                        color: restaurant['color'] as Color,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  restaurant['color'] as Color,
                                  Colors.white
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                restaurant['icon'] as String,
                                style: const TextStyle(fontSize: 70),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.favorite_border,
                                  color: AppColors.error, size: 20),
                            ),
                          ),
                        ],
                      ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant['name'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.success, size: 14),
                                  const SizedBox(width: 2),
                                  Text(
                                    restaurant['rating'] as String,
                                    style: const TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          restaurant['cuisine'] as String,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: AppColors.grey),
                            const SizedBox(width: 4),
                            Text(
                              restaurant['time'] as String,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.delivery_dining,
                                size: 14, color: AppColors.grey),
                            const SizedBox(width: 4),
                            Text(
                              restaurant['delivery'] as String,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
             )
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      backgroundColor: AppColors.white,
      elevation: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}