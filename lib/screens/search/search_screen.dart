import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  final List<Map<String, dynamic>> _allRestaurants = [
    {
      'name': 'Pizza Palace',
      'cuisine': 'Italian • Pizza',
      'icon': '🍕',
    },
    {
      'name': 'Burger Barn',
      'cuisine': 'American • Burgers',
      'icon': '🍔',
    },
    {
      'name': 'Sushi World',
      'cuisine': 'Japanese • Sushi',
      'icon': '🍣',
    },
    {
      'name': 'Noodle House',
      'cuisine': 'Chinese • Noodles',
      'icon': '🍜',
    },
  ];

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = _allRestaurants
          .where((restaurant) =>
              restaurant['name'].toLowerCase().contains(query.toLowerCase()) ||
              restaurant['cuisine'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search restaurants or food...',
                  hintStyle: const TextStyle(color: AppColors.grey),
                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildTrending()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrending() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: AppColors.grey.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'Find your favorite food',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          "No restaurants found.",
          style: TextStyle(color: AppColors.grey.withOpacity(0.8)),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Text(item['icon'], style: const TextStyle(fontSize: 30)),
            title: Text(
              item['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item['cuisine'],
              style: const TextStyle(color: AppColors.grey, fontSize: 13),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
            onTap: () {
              // Can navigate to detail screen if we pass all data, but this is sufficient for functionality.
            },
          ),
        );
      },
    );
  }
}
