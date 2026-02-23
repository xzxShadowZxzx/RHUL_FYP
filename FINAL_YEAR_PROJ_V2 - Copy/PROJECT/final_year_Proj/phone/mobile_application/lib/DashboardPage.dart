import 'package:flutter/material.dart';
import 'package:mobile_application/AF1Page.dart';
import 'package:mobile_application/Bape_Page.dart';
import 'package:mobile_application/Chain_Page.dart';
import 'package:mobile_application/J1Page.dart';
import 'package:mobile_application/MK_Page.dart';
import 'package:mobile_application/Ring_Page.dart';
import 'package:mobile_application/SpezialPage.dart';
import 'package:mobile_application/YeezyPage.dart';
import 'CategoriesPage.dart';
import 'ProfilePage.dart';
import 'CartPage.dart';

class Dashboardpage extends StatelessWidget {
  const Dashboardpage({super.key});

  final List<Map<String, String>> products = const [ // Map of the products
    {'name': 'Air Jordan 1 Lost & Found', 'price': '£200', 'image': 'assets/J1_LostnFound.webp'},
    {'name': 'Bape Hat', 'price': '£140', 'image': 'assets/Bape_hat.png'},
    {'name': '14K Gold Ring', 'price': '£2000', 'image': 'assets/14K_ring.webp'},
    {'name': 'Moose Knuckles Coat', 'price': '£999', 'image': 'assets/MK_coat.webp'},
    {'name': 'Adidas Spezial', 'price': '£99', 'image': 'assets/adidas_spez.webp'},
    {'name': 'Air Force 1 White', 'price': '£110', 'image': 'assets/AF1_white.webp'},
    {'name': 'Adidas Yeezy Foam Runner', 'price': '£115', 'image': 'assets/Foam_runner.webp'},
    {'name': 'Gold Chain', 'price': '£2099', 'image': 'assets/gold_chain.png'},
  ];

  final Map<String, Widget> productPages = const {
    'Air Jordan 1 Lost & Found': J1Page(),
    'Bape Hat': Bape_Page(),
    '14K Gold Ring': Ring_Page(),
    'Moose Knuckles Coat': MK_Page(),
    'Adidas Spezial': SpezialPage(),
    'Air Force 1 White': AF1Page(),
    'Adidas Yeezy Foam Runner': YeezyPage(),
    'Gold Chain': Chain_Page(),
  };

  @override
  Widget build(BuildContext context) {// Top Nav Bar
    return Scaffold(
      backgroundColor: Colors.grey.shade900, 
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent, 
          ),
        ),
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
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
                },
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView( // Main Display
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9), 
                ),
              ),
            ),
            SizedBox(
              height: 220, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Slider
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      final page = productPages[product['name']];
                      if (page != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
                      }
                    },// Navigation to respective products
                    child: Container(
                      width: 160, 
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              product['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black87],
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    product['price']!,
                                    style: TextStyle(color: Colors.purpleAccent.shade200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7, 
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () {
                    final page = productPages[product['name']];
                    if (page != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800, 
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(product['image']!, fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['price']!,
                                style: TextStyle(color: Colors.purpleAccent.shade200, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container( // Bottom Nav Bar
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade800, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: 0,
          showSelectedLabels: false, 
          showUnselectedLabels: false,
          elevation: 0, 
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
          onTap: (index) {
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