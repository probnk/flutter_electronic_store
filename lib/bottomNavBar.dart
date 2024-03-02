import 'package:electronic_store_app/Cart.dart';
import 'package:electronic_store_app/Favourite.dart';
import 'package:electronic_store_app/HomePage.dart';
import 'package:electronic_store_app/Products.dart';
import 'package:electronic_store_app/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> Pages = [
    HomePage(),
    Favourite(), // Pass the list here
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GNav(
              gap: 5,
              curve: Curves.easeIn,
              backgroundColor: Colors.black,
              rippleColor: Colors.cyan,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),
              tabBackgroundGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade500, Colors.purple.shade500]
              ),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  if(index==3){
                    _selectedIndex=0;
                  }
                  else{
                    _selectedIndex = index;
                  }
                });
              },
              tabs: [
                GButton(
                    iconColor: Colors.white,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.home,
                    text: 'Home'
                ),
                GButton(
                    iconColor: Colors.white,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.heart,
                    text: 'Favourite'
                ),
                GButton(
                    iconColor: Colors.white,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.addToShoppingCart,
                    text: 'Cart'
                ),
                GButton(
                    onPressed:(){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>UserProfile()
                        )
                      );
                    },
                    iconSize: 25,
                    iconColor: Colors.white,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.user,
                    text: 'Profile'
                ),
              ]
          ),
        ),
      ),
      body: Pages[_selectedIndex],
    );
  }
}
