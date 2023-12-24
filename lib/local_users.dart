import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:async';

class LocalUserListScreen extends StatefulWidget {
  @override
  _LocalUserListScreenState createState() => _LocalUserListScreenState();
}

class _LocalUserListScreenState extends State<LocalUserListScreen> {
  List<User> localUserList = [];
  DBHelper databaseHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    fetchLocalUsers();
  }

  Future<void> fetchLocalUsers() async {
    List<User> users = await databaseHelper.test_read("user.db");

    setState(() {
      localUserList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local User List Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local User List:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: localUserList.length,
                itemBuilder: (context, index) {
                  final user = localUserList[index];
                  return FadeInAnimation(
                    delay:
                        Duration(milliseconds: index * 100), // Adjust the delay
                    child: ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.email ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeInAnimation extends StatefulWidget {
  final Duration delay;
  final Widget child;

  FadeInAnimation({required this.delay, required this.child});

  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
