import 'package:ecommerce/models/address.dart';
import 'package:ecommerce/models/order.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

List<Category> categories = [
  Category(
    id: '1',
    name: 'Electronics',
    icon: 'electrical_services',
    color: const Color(0xFF6C63FF),
  ),
  Category(id: '2', name: 'Fashion', icon: 'fashion', color: Colors.pink),
  Category(id: '3', name: 'Home', icon: 'kitchen', color: Colors.orange),
  Category(id: '4', name: 'Sports', icon: 'sports', color: Colors.green),
  Category(id: '5', name: 'Books', icon: 'menu_book', color: Colors.blue),
  Category(
    id: '6',
    name: 'Beauty',
    icon: 'beauty_services',
    color: Colors.purple,
  ),
  Category(id: '7', name: 'Toys', icon: 'toys', color: Colors.red),
  Category(id: '8', name: 'Food', icon: 'food', color: Colors.amber),
];
List<Product> featuredProducts = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    description: 'Noise cancelling wireless headphones with premium sound',
    price: 199.99,
    discountPrice: 149.99,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    images: [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    ],
    rating: 4.5,
    reviews: 128,
    category: 'Electronics',
    isFeatured: true,
    isNew: true,
  ),
  Product(
    id: '2',
    name: 'Smart Watch',
    description: 'Fitness tracker with heart rate monitor',
    price: 299.99,
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    images: [
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    ],
    rating: 4.2,
    reviews: 89,
    category: 'Electronics',
    isFeatured: true,
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    description: 'Lightweight running shoes for athletes',
    price: 89.99,
    discountPrice: 69.99,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    images: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400'],
    rating: 4.7,
    reviews: 256,
    category: 'Sports',
    isFeatured: true,
    isNew: true,
  ),
  Product(
    id: '4',
    name: 'Backpack',
    description: 'Waterproof backpack with laptop compartment',
    price: 49.99,
    imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
    images: ['https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400'],
    rating: 4.3,
    reviews: 67,
    category: 'Fashion',
    isFeatured: true,
  ),
];
// Add these lists to existing dummy_data.dart

List<Address> addresses = [
  Address(
    id: '1',
    name: 'John Doe',
    street: '123 Main Street',
    city: 'New York',
    state: 'NY',
    zipCode: '10001',
    country: 'United States',
    phone: '+1 (555) 123-4567',
    isDefault: true,
  ),
  Address(
    id: '2',
    name: 'Jane Smith',
    street: '456 Park Avenue',
    city: 'Los Angeles',
    state: 'CA',
    zipCode: '90001',
    country: 'United States',
    phone: '+1 (555) 987-6543',
    isDefault: false,
  ),
];

List<Order> dummyOrders = [
  Order(
    id: 'ORD-784512',
    date: DateTime.now().subtract(const Duration(days: 2)),
    total: 256.98,
    status: 'Delivered',
    itemCount: 3,
    items: [
      OrderItem(
        productId: '1',
        productName: 'Wireless Headphones',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        quantity: 1,
        price: 149.99,
      ),
      OrderItem(
        productId: '3',
        productName: 'Running Shoes',
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        quantity: 2,
        price: 139.98,
      ),
    ],
  ),
  Order(
    id: 'ORD-451236',
    date: DateTime.now().subtract(const Duration(days: 5)),
    total: 89.99,
    status: 'Processing',
    itemCount: 1,
    items: [
      OrderItem(
        productId: '4',
        productName: 'Backpack',
        imageUrl:
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
        quantity: 1,
        price: 49.99,
      ),
    ],
  ),
];
