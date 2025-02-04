import 'package:flutter/material.dart';

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

  void _processPayment() {
    if (_cardNumberController.text.isNotEmpty &&
        _expiryDateController.text.isNotEmpty &&
        _cvvController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields!")),
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
        child: Column(
          children: [
            Text("Total: \$${widget.totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(labelText: "Card Number", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _expiryDateController,
              decoration: InputDecoration(labelText: "Expiry Date", border: OutlineInputBorder()),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cvvController,
              decoration: InputDecoration(labelText: "CVV", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processPayment,
              child: Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}
