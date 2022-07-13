import 'package:flutter/material.dart';
import 'package:unsecret/screens/main_windows/global_chat.dart';
import 'package:unsecret/screens/main_windows/personal_chat.dart';
import 'package:unsecret/screens/main_windows/profile.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final screen = [
    const GlobalChat(),
    const PersonalChat(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: IndexedStack(
          index: _selectedIndex,
          children: screen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green[50],
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() {
                  _selectedIndex = index;
                }),
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.public), label: "Global Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded), label: "Personal Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
      ),
    );
  }
}
