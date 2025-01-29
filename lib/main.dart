import 'package:cb011999/screens/about/about_us_screen.dart';
import 'package:cb011999/screens/home/home_screen.dart';
import 'package:cb011999/screens/product/single_product_screen.dart';
import 'package:cb011999/screens/registration/login_screen.dart';
import 'package:cb011999/screens/subscription/subscription_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<int> _navigationStack = [0];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SubscriptionScreen(),
    SingleProductScreen(),
    AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
    });
  }

  void _handleBackPress() {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigationStack.length > 1) {
          _handleBackPress();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _navigationStack.length > 1
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _handleBackPress,
                )
              : null,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Subscription',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_mark_outlined),
              label: 'About',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF6DBF73),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
