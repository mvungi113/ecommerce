import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: 'assets/icons/home.svg',
            label: 'Home',
            isSelected: selectedIndex == 0,
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          _NavBarItem(
            icon: 'assets/icons/category.svg',
            label: 'Categories',
            isSelected: selectedIndex == 1,
            onTap: () {},
          ),
          _NavBarItem(
            icon: 'assets/icons/cart.svg',
            label: 'Cart',
            isSelected: selectedIndex == 2,
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          _NavBarItem(
            icon: 'assets/icons/profile.svg',
            label: 'Profile',
            isSelected: selectedIndex == 3,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            color: isSelected ? const Color(0xFF6C63FF) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF6C63FF) : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}