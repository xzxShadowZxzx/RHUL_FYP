import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'CheckoutPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartItems;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() { // Loads Items into Cart
    final dbHelper = DatabaseHelper();
    setState(() {
      _cartItems = dbHelper.getCartItems();
    });
  }

  void _removeItem(int index, Map<String, dynamic> item) async { // Removes Items
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteCartItem(item['id']);
    _loadCartItems();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from cart.')),
    );
  }

  void _updateQuantity(int index, Map<String, dynamic> item, int newQuantity) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.updateCartItemQuantity(item['id'], newQuantity);
    _loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.grey.shade900, 
        foregroundColor: Colors.purpleAccent.shade200,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { // Checks if Cart is empty
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          } else {
            final cartItems = snapshot.data!;
            double total = 0;
            for (var item in cartItems) {
              total += item['price'] * item['quantity'];
            }

            return Column( // Presents the Cart on Cards.
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card( 
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.purpleAccent, width: 2.0), 
                          borderRadius: BorderRadius.circular(4.0), 
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['productName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Size: ${item['size']}'),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: item['quantity'] > 1 ? () {_updateQuantity(index, item, item['quantity'] -1);} : null ,
                                            icon: const Icon(Icons.remove)),
                                        Text('Quantity: ${item['quantity']}'),
                                        IconButton(
                                            onPressed: () {_updateQuantity(index, item, item['quantity'] +1);},
                                            icon: const Icon(Icons.add)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text('£${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeItem(index, item),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: £${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.greenAccent)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CheckoutPage(totalPrice: total)),
                          );
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}