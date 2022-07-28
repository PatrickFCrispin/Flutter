import 'package:flutter/material.dart';
import 'package:get_users_from_public_api/models/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name.toString()),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(Icons.email, color: Colors.blue),
          title: Text(user.email.toString()),
          subtitle: Text(user.username.toString()),
        ),
      )
    );
  }
}