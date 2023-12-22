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
                  return ListTile(
                    title: Text(user.name ?? ''),
                    subtitle: Text(user.email ?? ''),
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
