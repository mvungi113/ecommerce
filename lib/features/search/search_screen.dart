import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/product.dart';
import '../../services/dummy_data.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'widgets/search_result_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  List<String> _recentSearches = [
    'Headphones',
    'Smart Watch',
    'Shoes',
    'Backpack',
  ];
  List<String> _popularSearches = [
    'Laptop',
    'Phone',
    'Camera',
    'Speaker',
    'Tablet',
  ];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final results = featuredProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = results;
    });

    // Add to recent searches if not already there
    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _performSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'electrical_services':
        return Icons.electrical_services;
      case 'fashion':
        return Icons.checkroom;
      case 'kitchen':
        return Icons.kitchen;
      case 'sports':
        return Icons.sports_basketball;
      case 'menu_book':
        return Icons.menu_book;
      case 'beauty_services':
        return Icons.face;
      case 'toys':
        return Icons.toys;
      case 'food':
        return Icons.restaurant;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
            ),
            autofocus: true,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _searchResults.isNotEmpty
          ? _buildSearchResults()
          : _buildInitialView(),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return SearchResultCard(product: product);
      },
    );
  }

  Widget _buildInitialView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            const Text(
              'Recent Searches',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return ActionChip(
                  label: Text(search),
                  onPressed: () {
                    _searchController.text = search;
                  },
                  avatar: const Icon(Icons.history, size: 16),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Popular Searches
          const Text(
            'Popular Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._popularSearches.map((search) {
            return ListTile(
              leading: const Icon(
                Icons.trending_up,
                size: 24,
                color: Color(0xFF6C63FF),
              ),
              title: Text(search),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                _searchController.text = search;
              },
            );
          }).toList(),

          const SizedBox(height: 32),

          // Browse Categories
          const Text(
            'Browse Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    _searchController.text = category.name;
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIconData(category.icon),
                          size: 30,
                          color: category.color,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: category.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
