import 'package:flutter/material.dart';
import 'package:get_users_from_public_api/view_models/user.view.model.dart';
import 'package:get_users_from_public_api/views/user.details.page.dart';

class UserPage extends StatefulWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var viewModel = UserViewModel();
  
  @override
  void initState() {
    super.initState();
    _loadUsersFromPublicApi();
  }

  void _loadUsersFromPublicApi() {
    viewModel.loadUsersFromPublicApi().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: viewModel.users.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(viewModel.users[index].name.toString()),
            subtitle: Text(viewModel.users[index].email.toString()),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(viewModel.users[index])
                ),
              );
            },
          );
        },
      ),
    );
  }
}