import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

import '../../services/dummy_data.dart';
import '../../main.dart';
import 'widgets/address_card.dart';
import 'widgets/payment_method_card.dart';
import 'widgets/summary_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentMethod = 0;
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: 'Credit Card',
      icon: 'assets/icons/credit_card.svg',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: 'PayPal',
      icon: 'assets/icons/paypal.svg',
      isDefault: false,
    ),
    PaymentMethod(
      id: '3',
      type: 'Apple Pay',
      icon: 'assets/icons/apple_pay.svg',
      isDefault: false,
    ),
    PaymentMethod(
      id: '4',
      type: 'Google Pay',
      icon: 'assets/icons/google_pay.svg',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double subtotal = cartProvider.totalPrice;
    final double shipping = subtotal > 50 ? 0 : 5.99;
    final double tax = subtotal * 0.08;
    final double total = subtotal + shipping + tax;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to address management
                  },
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OpenContainer(
              closedBuilder: (context, action) {
                return AddressCard(
                  address: addresses[_selectedAddressIndex],
                  isSelected: true,
                );
              },
              openBuilder: (context, action) {
                return _buildAddressSelectionScreen();
              },
            ),

            const SizedBox(height: 32),

            // Payment Method
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: _paymentMethods.asMap().entries.map((entry) {
                final index = entry.key;
                final method = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PaymentMethodCard(
                    method: method,
                    isSelected: _selectedPaymentMethod == index,
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = index;
                      });
                    },
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SummaryCard(
              subtotal: subtotal,
              shipping: shipping,
              tax: tax,
              total: total,
            ),

            const SizedBox(height: 32),

            // Promo Code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/discount.svg',
                    width: 24,
                    height: 24,
                    color: const Color(0xFF6C63FF),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Have a promo code?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showPromoCodeDialog();
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _showOrderConfirmation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSelectionScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new address
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AddressCard(
              address: addresses[index],
              isSelected: _selectedAddressIndex == index,
              onTap: () {
                setState(() {
                  _selectedAddressIndex = index;
                });
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }

  void _showPromoCodeDialog() {
    final TextEditingController promoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Promo Code'),
          content: TextField(
            controller: promoController,
            decoration: InputDecoration(
              hintText: 'e.g., SUMMER20',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Apply promo code logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Promo code applied successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderConfirmation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 40, color: Colors.green),
              ),
              const SizedBox(height: 24),
              const Text(
                'Order Placed Successfully!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your order has been confirmed\nand will be shipped soon',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    _buildOrderDetailRow('Order ID', '#ORD-784512'),
                    _buildOrderDetailRow('Date', 'Nov 28, 2024'),
                    _buildOrderDetailRow('Total', '\$256.98'),
                    _buildOrderDetailRow('Payment', 'Credit Card'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigate to orders screen
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('View Orders'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Continue Shopping'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
