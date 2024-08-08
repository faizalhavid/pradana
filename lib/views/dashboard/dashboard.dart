import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/views/dashboard/favorite.dart';
import 'package:pradana/views/dashboard/home.dart';
import 'package:pradana/views/dashboard/profile.dart';
import 'package:pradana/views/dashboard/watchlist.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WatchlistScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Column(
            children: [
              Expanded(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              useLegacyColorScheme: true,
              selectedItemColor: ColorResources.secondaryColor,
              onTap: _onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: ColorResources.neutral300,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    Icons.movie,
                    0,
                    isDarkMode,
                  ),
                  label: 'Home',
                  backgroundColor: isDarkMode == Brightness.light
                      ? ColorResources.neutral0
                      : ColorResources.neutral700,
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    Icons.bookmark,
                    1,
                    isDarkMode,
                  ),
                  label: 'Watchlist',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    Icons.favorite,
                    2,
                    isDarkMode,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    Icons.person,
                    3,
                    isDarkMode,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index, bool isDark) {
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
              color: isDark == Brightness.light
                  ? ColorResources.neutral0
                  : ColorResources.neutral400,
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
