import 'package:flutter/material.dart';
import 'package:mobile_application/DashboardPage.dart';
import 'package:mobile_application/PaymentAnimationsPage.dart';
import 'package:mobile_application/database_helper.dart';
import 'PaymentAnimationsPage.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;
  const CheckoutPage({super.key, required this.totalPrice});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> { // Controller
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.purpleAccent.shade200,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[ // Text Fields
                _buildTextField(_nameController, 'Full Name', TextInputType.name),
                _buildTextField(_addressController, 'Shipping Address', TextInputType.streetAddress),
                _buildTextField(_phoneController, 'Phone Number', TextInputType.phone, isPhone: true),
                _buildTextField(_emailController, 'Email Address', TextInputType.emailAddress, isEmail: true),
                _buildTextField(_cardNumberController, 'Card Number', TextInputType.number, isCard: true),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(_expiryDateController, 'Expiry Date (MM/YY)', TextInputType.datetime, isExpiry: true),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(_cvvController, 'CVV', TextInputType.number, isCVV: true),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Total Price: £${widget.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _processPayment(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Place Order'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType inputType, {bool isPhone = false, bool isEmail = false, bool isCard = false, bool isExpiry = false, bool isCVV = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: inputType,
        validator: (value) { // Validator
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          if (isPhone && value.length < 10) {
            return 'Enter a valid phone number';
          }
          if (isEmail && !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
            return 'Enter a valid email address';
          }
          if (isCard && value.length < 16) {
            return 'Enter a valid 16-digit card number';
          }
          if (isExpiry && !RegExp(r"^(0[1-9]|1[0-2])/[0-9]{2}$").hasMatch(value)) {
            return 'Enter expiry in MM/YY format';
          }
          if (isCVV && value.length < 3) {
            return 'Enter a valid CVV';
          }
          return null;
        },
      ),
    );
  }

  void _processPayment(BuildContext context) { // Process Payment
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your order has been placed! \n A confirmation Email has been sent.' ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                DatabaseHelper dbHelper = DatabaseHelper();
                await dbHelper.deleteCart();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentAnimationsPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
