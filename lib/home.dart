import 'package:contacts/screens/search.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/rooms.dart';
import 'screens/settings.dart';
import 'widgets/drawer.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    ContactsHome(),
    const RoomsPage(),
    const Profile(),
    const Settings(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Search(),
              ),
            );
          },
          child: const Text(
            "Search Here",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          ),
          const SizedBox(width: 20.0),
        ],
        titleSpacing: 0.0,
      ),
      drawer: const DrawerWidget(),
      body: IndexedStack(
        index: selectedIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}