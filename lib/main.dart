import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ChatSystem/chat_login_screen.dart';
import 'Screens/calculator_screen.dart';
import 'Screens/conversion_screen.dart'; // Import for Konversi screen
import 'Screens/home_fragment.dart';
import 'Screens/videos_fragment.dart';
import 'Screens/about_fragment.dart';
import 'Screens/contacts_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.grey, // Grey theme
        scaffoldBackgroundColor: Colors.grey[200], // Light grey background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[800], // Dark grey AppBar
          foregroundColor: Colors.white, // Text color in AppBar
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[300], // Dark grey FAB
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[300], // Light grey drawer background
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[900]), // Default text color
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _fragments = [
    HomeFragment(),
    VideosFragment(),
    AboutFragment(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[800]),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.calculate, color: Colors.grey[800]),
              title: Text('Kalkulator', style: TextStyle(color: Colors.grey[800])),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculatorScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz, color: Colors.grey[800]), // Icon for Konversi
              title: Text('Konversi', style: TextStyle(color: Colors.grey[800])),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _fragments[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatLoginScreen()),
          );
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
