import 'package:flutter/material.dart';
import 'package:user_list/models/user.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  UserDetailsPage(this.user);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name.toString()),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text(widget.user.phone.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue,),
              title: Text(widget.user.email.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.edit),
        onPressed: () {
          _showEditDialog(context);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var cancelButton = TextButton(
      child: Text('Cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    var saveButton = TextButton(
      child: Text('Salvar'),
      onPressed: () {
        if (_formKey.currentState!.validate()){
          _formKey.currentState!.save();
          setState(() {});
          Navigator.of(context).pop();
        }
      },
    );

    var editDialog = AlertDialog(      
      title: Text('Edição'),
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  initialValue: widget.user.name,
                  maxLength: 40,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.user.name = val;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  initialValue: widget.user.phone,
                  maxLength: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Telefone inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.user.phone = val;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  initialValue: widget.user.email,
                  maxLength: 40,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-mail inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.user.email = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        cancelButton,
        saveButton,
      ],
    );

    showDialog(context: context, builder: (context) => editDialog);
  }
}