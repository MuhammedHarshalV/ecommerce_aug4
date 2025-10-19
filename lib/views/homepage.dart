import 'package:ecommerce_aug4/views/bottomnavscreen/accountscreen.dart';
import 'package:ecommerce_aug4/views/bottomnavscreen/cart.dart';
import 'package:ecommerce_aug4/views/bottomnavscreen/productlist.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int navindex = 0;
  List screens = [Productlist(), CartScreen(), Accountscreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[navindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink[100],

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: navindex,
        onTap: (value) {
          navindex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home_outlined, color: Colors.black),
            activeIcon: Icon(Icons.home, color: Colors.white),
          ),

          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            activeIcon: Icon(Icons.shopping_bag, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.person_2_outlined, color: Colors.black),
            activeIcon: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
