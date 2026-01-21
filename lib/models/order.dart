import 'package:flutter/material.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;
  final String status;
  final int itemCount;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.itemCount,
    required this.items,
  });

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
  Color get statusColor {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

class PaymentMethod {
  final String id;
  final String type;
  final String icon;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.icon,
    required this.isDefault,
  });
}
