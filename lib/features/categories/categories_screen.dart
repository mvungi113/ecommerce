import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';

import '../../services/dummy_data.dart';
import '../product/product_detail_screen.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'widgets/category_list_item.dart';
import 'widgets/filter_sheet.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedCategory = 'All';
  final List<String> _sortOptions = [
    'Popular',
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
  ];
  String _selectedSort = 'Popular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/search.svg'),
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
                            SvgPicture.asset(
                              'assets/icons/filter.svg',
                              width: 20,
                              height: 20,
                            ),
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
                          // Apply filters
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
                        icon: SvgPicture.asset(
                          'assets/icons/arrow_down.svg',
                          width: 16,
                          height: 16,
                        ),
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
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return OpenContainer(
                  closedBuilder: (context, action) {
                    return CategoryListItem(product: product);
                  },
                  openBuilder: (context, action) {
                    return ProductDetailScreen(product: product);
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
