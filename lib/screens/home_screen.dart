import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'add_student_screen.dart';
import 'view_students_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xff121f60),
      appBar: AppBar(
        title: Text('Teacher Student App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],backgroundColor: Colors.purple,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AddStudentScreen(),
          ViewStudentsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Students',
          ),
        ],
      ),
    );
  }
}
