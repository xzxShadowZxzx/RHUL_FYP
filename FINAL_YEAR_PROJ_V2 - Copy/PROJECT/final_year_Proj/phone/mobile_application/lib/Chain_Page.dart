import 'package:flutter/material.dart';
import 'package:mobile_application/CartAnimationsPage.dart';
import 'DashboardPage.dart';
import 'ProfilePage.dart';
import 'CategoriesPage.dart';
import 'database_helper.dart';
import 'CartPage.dart';

class Chain_Page extends StatefulWidget {
  const Chain_Page({super.key});

  @override
  _ChainPageState createState() => _ChainPageState();
}

class _ChainPageState extends State<Chain_Page> {
  String? selectedSize = 'XS'; 
  int quantity = 1; 

  Future<void> _addToCart() async { // Add items to shopping cart
      final dbHelper = DatabaseHelper();

      Map<String, dynamic> item = { // Creates a map of the items.
        'productName': '24K Golden Chain',
        'size': selectedSize,
        'quantity': quantity,
        'price': 2099.00,
      };

      await dbHelper.insertCartItem(item);

      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CartAnimationsPage()), // Plays Animation
      );
    } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('24K Golden Chain', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.purpleAccent.shade200,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const CartPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = 0.0;
                    const end = 1.0;
                    const curve = Curves.easeInOutQuart;
                    var scaleAnimation = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)).animate(animation);
                    return ScaleTransition(
                      scale: scaleAnimation,
                      child: child,
                    );
                  },
                ),
              );
          }),
        ],
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/gold_chain.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300.0, 
                ),
              ),
              const SizedBox(height: 16.0),
              
              
              const Text( //Title
                '24K Gold Chain',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text( // Price
                '£2099',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.purpleAccent,
                ),
              ),
              const SizedBox(height: 16.0),

              
              const Text( // Description
                "\n",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Size:',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButton<String>(
                        hint: const Text(
                          'Choose size',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: selectedSize,
                        items: <String>['XS', 'S', 'M', 'L', 'XL'] // Drop Down
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value;
                          });
                        },
                        dropdownColor: Colors.grey.shade900,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              Center( // Add to Cart
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                  ),
                  child: const Text('Add to Cart', style: TextStyle(fontSize: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: Container( // Bottom Navigation Bar
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade800, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.purpleAccent.shade200,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: 1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const Dashboardpage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutQuart;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              );
            }

            if (index == 1) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const CategoriesPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutQuart;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              );
            }

            if (index == 2) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutQuart;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
