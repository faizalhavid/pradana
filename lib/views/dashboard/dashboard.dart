import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/views/dashboard/home.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('Search Page'),
    Text('Profile Page'),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: ColorResources.secondaryColor,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: ColorResources.neutral200,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.movie, 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.bookmark, 1),
                label: 'Watchlist',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(Icons.favorite, 2),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  Icons.person,
                  3,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = _selectedIndex == index;
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isSelected)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorResources.neutral0,
            ),
          ),
        Icon(
          iconData,
          size: 25,
        ),
      ],
    );
  }
}
