import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:store/widgets/addProduct.dart';
import 'package:store/widgets/search.dart';

import 'category.dart';
import 'home.dart';
import 'profile.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  List<Widget> _bottomBarOptions = <Widget>[
    Home(), //Home
    Search(),
    MyAddNewProductPage(),
    Category(),
    Profile(),
  ];

  void _changeItem(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.deepOrange,
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.add_shopping_cart_rounded, title: 'Add'),
          TabItem(icon: Icons.category, title: 'Category'),
          TabItem(icon: Icons.account_circle, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        //optional, default as 0
        onTap: _changeItem,
      ),
      body: _bottomBarOptions.elementAt(_currentIndex),
    );
  }
}
