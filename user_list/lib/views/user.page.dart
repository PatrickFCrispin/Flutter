import 'package:flutter/material.dart';
import 'package:user_list/view_models/user.view.model.dart';
import 'package:user_list/views/user.add.page.dart';
import 'package:user_list/views/user.details.page.dart';

class UserPage extends StatefulWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var viewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        // OUTRA FORMA DE ADICIONAR UM BOTÃO, MAS COM TEXTO AO INVÉS DE ICON, É UTILIZAR UM 'TEXTBUTTON':
        // actions: <Widget>[
        //   TextButton(
        //     child: Text('Adicionar', style: TextStyle(fontSize: 16, color: Colors.white),),
        //     onPressed: () {
        //       Navigator.push(
        //         context, 
        //         MaterialPageRoute(builder: (context) => UserAddPage(viewModel))).then((value) {
        //           setState(() {
        //             viewModel.refreshUserList();
        //           });
        //         },
        //       );
        //     },
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: viewModel.users.length,
        itemBuilder: (context, int index) {
          final user = viewModel.users[index];
          return Dismissible(
            key: Key(user.id.toString()),
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(0.9, 0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text(user.name.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => UserDetailsPage(user))).then((value) {
                    setState(() {
                      viewModel.refreshUserList();
                    });
                  },
                );
              },
              onLongPress: () {
                _showConfirmRemovalDialog(context, user.name.toString(), index);
              },
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _remove(index);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${user.name} removido(a)')));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => UserAddPage(viewModel))).then((value) {
              setState(() {
                viewModel.refreshUserList();
              });
            },
          );
        },
      ),
    );
  }

  void _remove(int index) {
    setState(() {
      viewModel.removeUser(index);
    });
  }

  void _showConfirmRemovalDialog(BuildContext context, String name, int index) {
    var cancelButton = TextButton(
      child: Text('Não, cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    var yesButton = TextButton(
      child: Text('Sim'),
      onPressed: () {
        _remove(index);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name removido(a)')));
        Navigator.of(context).pop();
      },
    );

    var confirmRemovalDialog = AlertDialog(
      title: Text('Atenção'),
      content: Text('Deseja remover o usuário $name?'),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    showDialog(context: context, builder: (context) => confirmRemovalDialog);
  }
}