import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date validation

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;

  CheckoutScreen({required this.totalPrice});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  bool _isCardNumberValid(String cardNumber) {
    // Card number must be at least 13 digits
    return cardNumber.length >= 13 && RegExp(r'^\d+$').hasMatch(cardNumber);
  }

  bool _isExpiryDateValid(String expiryDate) {
    try {
      // Expiry Date format MM/YY
      final expiry = DateFormat("MM/yy").parseStrict(expiryDate);
      final currentDate = DateTime.now();
      return expiry.isAfter(currentDate); // Expiry date must be in the future
    } catch (e) {
      return false;
    }
  }

  bool _isCvvValid(String cvv) {
    // CVV should be exactly 3 digits
    return cvv.length == 3 && RegExp(r'^\d{3}$').hasMatch(cvv);
  }

  void _processPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields correctly!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assigning the form key for validation
          child: Column(
            children: [
              Text("Total: \$${widget.totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              // Card Number TextField with validation
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: "Card Number", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Card number is required';
                  } else if (!_isCardNumberValid(value)) {
                    return 'Enter a valid card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Expiry Date TextField with validation
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: "Expiry Date (MM/YY)", border: OutlineInputBorder()),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Expiry date is required';
                  } else if (!_isExpiryDateValid(value)) {
                    return 'Enter a valid expiry date (MM/YY)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // CVV TextField with validation
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: "CVV", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CVV is required';
                  } else if (!_isCvvValid(value)) {
                    return 'Enter a valid 3-digit CVV';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Payment Button
              ElevatedButton(
                onPressed: _processPayment,
                child: Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
