import 'package:flutter/material.dart';
import 'package:user_list/view_models/user.view.model.dart';

class UserAddPage extends StatefulWidget {
  UserViewModel viewModel;
  UserAddPage(this.viewModel);

  @override
  _UserAddPageState createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo usuário'),
      ),
      body: SingleChildScrollView(
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
                  maxLength: 40,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.viewModel.name = val;
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
                  maxLength: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Telefone inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.viewModel.phone = val;
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
                  maxLength: 40,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'E-mail inválido!';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    widget.viewModel.email = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                widget.viewModel.isBusy 
                ? Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    )
                  ),
                ) 
                : TextButton(
                  child: Text('Adicionar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {});
                      add();
                      _formKey.currentState!.reset();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> add() async {
    await widget.viewModel.newUser(widget.viewModel);
    setState(() {});
  }
}