import 'package:flutter/material.dart';
import 'package:mobile_application/JewelleryPage.dart';
import 'package:mobile_application/ShirtsPage.dart';
import 'package:mobile_application/DashboardPage.dart';
import 'package:mobile_application/ProfilePage.dart';
import 'package:mobile_application/SneakersPage.dart';
import 'package:mobile_application/HatsPage.dart';
import 'package:mobile_application/CoatsPage.dart';
import 'package:mobile_application/CartPage.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  // Map
  final List<Map<String, String>> categories = const [
    {'name': 'Coats & Jackets', 'image': 'assets/MK_coat.webp'},
    {'name': 'Hats & Caps', 'image': 'assets/Bape_hat.png'},
    {'name': 'Jewellery', 'image': 'assets/14K_ring.webp'},
    {'name': 'Sneakers', 'image': 'assets/J1_LostnFound.webp'},
    {'name': 'Shirts', 'image': 'assets/Moncler.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900, 
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent, 
          ),
        ),
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        foregroundColor: Colors.purpleAccent.shade200, 
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
                        ); // Transition
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85, 
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector( // Differnent Categories
            onTap: () {
              if (category['name'] == 'Sneakers') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Sneakerspage()),
                );
              }
              if (category['name'] == 'Hats & Caps') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Hatspage()),
                );
              }
              if (category['name'] == 'Jewellery') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Jewellerypage()),
                );
              }
              if (category['name'] == 'Coats & Jackets') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CoatsPage()),
                );
              }
              if (category['name'] == 'Shirts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShirtsPage()),
                );
              }
            },
            child: Container( // Presents them on Cards.
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
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
                      category['image']!,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                      color: Colors.black38, 
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                      child: Text(
                        category['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container( // Bottom Navigation
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