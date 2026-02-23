import 'package:flutter/material.dart';
import 'package:mobile_application/HRPage.dart';
import 'package:mobile_application/ProfileDetailsPage.dart';
import 'CategoriesPage.dart';
import 'DashboardPage.dart';
import 'CartPage.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent, 
          ),
        ),
        backgroundColor: Colors.grey.shade900, 
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
                  Navigator.push( // Cart
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile_pic.webp'), // img
          ),
          const SizedBox(height: 10),
          const Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // name
          const Text('john99doe@email.com', style: TextStyle(color: Colors.grey)), //email
          const SizedBox(height: 20),
          ListTile( // Tiles of Lists
            leading: const Icon(Icons.person_2, color: Colors.deepPurpleAccent),
            title: const Text('Profile Details'), 
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailsPage()),
                );
            },
          ),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.card_giftcard, color: Colors.deepOrangeAccent),
            title: const Text('Promo Codes and Coupons'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.shopping_bag, color: Colors.greenAccent),
            title: const Text('My Orders'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.favorite, color: Colors.redAccent),
            title: const Text('Wish List'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.location_on, color: Colors.blueAccent),
            title: const Text('Addresses'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.message, color: Colors.black45),
            title: const Text('Help and Support'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hrpage()),
                );
            },
          ),
          ListTile(// Tiles of Lists
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade800, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.purpleAccent.shade200,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: 2,
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
          },
        ),
      ),
    );
  }
}
