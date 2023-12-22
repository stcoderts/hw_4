import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'users_list.dart';
import 'local_users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW4 App',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/user_list': (context) => UserListScreen(),
        '/local_user_list': (context) => LocalUserListScreen(),
      },
    );
  }
}
