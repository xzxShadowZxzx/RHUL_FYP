import 'package:flutter/material.dart';
import 'CategoriesPage.dart';
import 'DashboardPage.dart';
import 'ProfilePage.dart';

class Hrpage extends StatelessWidget {
  const Hrpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent),
        ),
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        foregroundColor: Colors.purpleAccent.shade200, 
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.search_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}), 
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              backgroundColor: Colors.grey.shade800,
              collapsedBackgroundColor: Colors.grey.shade800,
              title: const Text(
                'How do I track my order(s)?',
                style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w500),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You can track your order by visiting the "My Orders" section in your profile. You will find a tracking number and link for each order.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              backgroundColor: Colors.grey.shade800,
              collapsedBackgroundColor: Colors.grey.shade800,
              title: const Text(
                'What is the return policy?',
                style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w500),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'We offer a 30-day return policy for most items. Please refer to your purchase email for more information',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              backgroundColor: Colors.grey.shade800,
              collapsedBackgroundColor: Colors.grey.shade800,
              title: const Text(
                'How can I contact support?',
                style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w500),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You can contact our support team via email at support@ZA.com or by calling us at +44 1234 567890. Our business hours are Monday to Friday, 9 AM to 6 PM GMT.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.grey.shade800,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Icon(Icons.email_outlined, color: Colors.purpleAccent.shade200),
                title: const Text('Email Support', style: TextStyle(color: Colors.white)),
                subtitle: Text('support@example.com', style: TextStyle(color: Colors.grey.shade400)),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.grey.shade800,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Icon(Icons.phone_outlined, color: Colors.purpleAccent.shade200),
                title: const Text('Call Us', style: TextStyle(color: Colors.white)),
                subtitle: Text('+44 1234 567890', style: TextStyle(color: Colors.grey.shade400)),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'More Help',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.question_answer_outlined, color: Colors.purpleAccent.shade200),
              title: const Text('Help Center', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.article_outlined, color: Colors.purpleAccent.shade200),
              title: const Text('Terms & Conditions', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shield_outlined, color: Colors.purpleAccent.shade200),
              title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
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
                    const begin = Offset(-1.0, 0.0);
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
                    const begin = Offset(1.0, 0.0);
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