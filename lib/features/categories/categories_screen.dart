import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../../models/product.dart';
import '../../services/dummy_data.dart';
import '../product/product_detail_screen.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'widgets/category_list_item.dart';
import 'widgets/filter_sheet.dart';

class CategoriesScreen extends StatefulWidget {
  final String? initialCategory;

  const CategoriesScreen({super.key, this.initialCategory});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late String _selectedCategory;
  final List<String> _sortOptions = [
    'Popular',
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
  ];
  String _selectedSort = 'Popular';
  double _minPrice = 0;
  double _maxPrice = 1000;
  List<String> _selectedBrands = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Chips
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ['All', ...categories.map((c) => c.name)].length,
              itemBuilder: (context, index) {
                final categoryName = index == 0
                    ? 'All'
                    : categories[index - 1].name;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(categoryName),
                    selected: _selectedCategory == categoryName,
                    selectedColor: const Color(0xFF6C63FF),
                    labelStyle: TextStyle(
                      color: _selectedCategory == categoryName
                          ? Colors.white
                          : Colors.black,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = categoryName;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Filter and Sort Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OpenContainer(
                    closedBuilder: (context, action) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.filter_list, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Filter',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return FilterSheet(
                        onApply: (minPrice, maxPrice, brands) {
                          setState(() {
                            _minPrice = minPrice;
                            _maxPrice = maxPrice;
                            _selectedBrands = brands;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        icon: const Icon(Icons.arrow_drop_down, size: 24),
                        isExpanded: true,
                        items: _sortOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSort = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: Builder(
              builder: (context) {
                // Filter products based on selected category
                var filteredProducts = _selectedCategory == 'All'
                    ? featuredProducts
                    : featuredProducts
                          .where(
                            (product) => product.category == _selectedCategory,
                          )
                          .toList();

                // Apply price filter
                filteredProducts = filteredProducts
                    .where(
                      (product) =>
                          product.finalPrice >= _minPrice &&
                          product.finalPrice <= _maxPrice,
                    )
                    .toList();

                // Apply brand filter
                if (_selectedBrands.isNotEmpty) {
                  filteredProducts = filteredProducts
                      .where(
                        (product) =>
                            product.brand != null &&
                            _selectedBrands.contains(product.brand),
                      )
                      .toList();
                }

                // Sort products based on selected sort option
                final sortedProducts = List<Product>.from(filteredProducts);
                switch (_selectedSort) {
                  case 'Price: Low to High':
                    sortedProducts.sort(
                      (a, b) => a.finalPrice.compareTo(b.finalPrice),
                    );
                    break;
                  case 'Price: High to Low':
                    sortedProducts.sort(
                      (a, b) => b.finalPrice.compareTo(a.finalPrice),
                    );
                    break;
                  case 'Rating':
                    sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
                    break;
                  case 'Newest':
                    // Could add a date field to Product model for this
                    break;
                  case 'Popular':
                  default:
                    sortedProducts.sort(
                      (a, b) => b.reviews.compareTo(a.reviews),
                    );
                    break;
                }

                if (sortedProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found in $_selectedCategory',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: sortedProducts.length,
                  itemBuilder: (context, index) {
                    final product = sortedProducts[index];
                    return OpenContainer(
                      closedBuilder: (context, action) {
                        return CategoryListItem(product: product);
                      },
                      openBuilder: (context, action) {
                        return ProductDetailScreen(product: product);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
