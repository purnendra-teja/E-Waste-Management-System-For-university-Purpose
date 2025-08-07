import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'browse_screen.dart';
import 'submit_ewaste_screen.dart';
import 'services_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final String? browseCategory;
  
  const MainScreen({
    super.key,
    this.initialIndex = 0,
    this.browseCategory,
  });

  // Static method to navigate to a specific tab
  static void navigateToTab(BuildContext context, int tabIndex) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/main') {
      // If we're already on MainScreen, find the MainScreen and update its state
      // This approach keeps the current instance and just changes the tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/main'),
          builder: (context) => MainScreen(initialIndex: tabIndex),
        ),
      );
    } else {
      // If coming from another screen, use regular navigation
      Navigator.pushReplacementNamed(
        context,
        '/main',
        arguments: tabIndex,
      );
    }
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  String? _browseCategory;
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _browseCategory = widget.browseCategory;
    print('MainScreen initialized with index: ${widget.initialIndex}, category: ${widget.browseCategory}');
  }

  void switchTab(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  // Create screens on demand to ensure updated props are passed
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return BrowseScreen(initialCategory: _browseCategory ?? 'All');
      case 2:
        return const SubmitEWasteScreen();
      case 3:
        return const ServicesScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              switchTab(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_module_rounded),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upload_file_rounded),
                label: 'Submit',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.build_circle_rounded),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
} 