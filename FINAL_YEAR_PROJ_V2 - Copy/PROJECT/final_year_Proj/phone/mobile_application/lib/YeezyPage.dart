import 'package:flutter/material.dart';
import 'package:mobile_application/CartAnimationsPage.dart';
import 'DashboardPage.dart';
import 'ProfilePage.dart';
import 'CategoriesPage.dart';
import 'database_helper.dart';
import 'CartPage.dart';



class YeezyPage extends StatefulWidget {
  const YeezyPage({super.key});

  @override
  _YeezyPageState createState() => _YeezyPageState();
}

class _YeezyPageState extends State<YeezyPage> {
  String? selectedSize = '6'; 
  int quantity = 1; 

  Future<void> _addToCart() async {
    final dbHelper = DatabaseHelper(); // Links to Database

    Map<String, dynamic> item = { // Map
      'productName': 'Adidas Yeezy Foam Runners',
      'size': selectedSize,
      'quantity': quantity,
      'price': 115,
    };

    await dbHelper.insertCartItem(item);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CartAnimationsPage()), // Animation
      );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Yeezy Foam Runners', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    );// Transition
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
                  'assets/Foam_runner.webp', // img
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 300.0, 
                ),
              ),
              const SizedBox(height: 16.0),
              
              
              const Text(
                'Foam Runners', // name
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                '£115', // price
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.purpleAccent,
                ),
              ),
              const SizedBox(height: 16.0),
              
              const Text( // Desc
                "Contemporary and cool Yeezy boasts street style-ready silhouettes, showcased in these Foam Runner Sliders.\n" 
                "Fully perforated for enhanced breathability this pair enhance your comfort with their soft feel, round toe and flat sole.\n" 
                "Futuristic and unique in shape these shoes are ideal as part of your weekend wardrobe.",
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
                        items: <String>['6', '7', '8', '9', '10', '11', '12'] // DropDown
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

              Center( // Add to Cart button
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
      
      bottomNavigationBar: Container(
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
