import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';
import 'package:exchange_security_list/app/store/user_profile_securities_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EditExchangeSecurityListPage extends StatelessWidget {
  var editingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.add_circle, color: Colors.blue),
              TextButton(
                child: Text('Adicionar', style: TextStyle(color: Colors.blue, fontSize: 16)),
                onPressed: () {
                  showAddNewExchangeSecurityForUserProfileInstrumentDialog(context);
                },
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: _createColumns(),
                  rows: Provider.of<UserProfileSecuritiesStore>(context).all.map((security) => _createRows(context, security)).toList(),
                  dataRowHeight: 65,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: const Text('Ativo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), numeric: false),
      DataColumn(label: const Text('Preço', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), numeric: false),
      DataColumn(label: const Text('Compra', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), numeric: false),
      DataColumn(label: const Text('Venda', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), numeric: false),
    ];
  }
  
  DataRow _createRows(BuildContext context, ExchangeSecurity security) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  showConfirmRemovalExchangeSecurityForUserProfileDialog(context, security);
                },
              ),
              Text(security.symbol.toString()),
            ],
          ),
        ),
        DataCell(Text(security.price.toString())),
        DataCell(Text(security.askPrice.toString())),
        DataCell(Text(security.bidPrice.toString())),
      ],
    );
  }
  
  void showAddNewExchangeSecurityForUserProfileInstrumentDialog(BuildContext context) {
    var cancelButton = TextButton(
      child: Text('Cancelar', style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    
    var addButton = TextButton(
      child: Text('Adicionar', style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
        addNewExchangeSecurityForUserProfileInstrument(context, editingController.text.toUpperCase());
      },
    );
    
    var addNewExchangeSecurityForUserProfileInstrumentDialog = AlertDialog(
      title: Text('Adicionar Ativo', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Informe um código de ativo.', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: editingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 16),
                labelText: 'Ativo',
              ),
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        addButton,
      ],
    );
    
    showDialog(context: context, builder: (context) => addNewExchangeSecurityForUserProfileInstrumentDialog);
  }
  
  void addNewExchangeSecurityForUserProfileInstrument(BuildContext context, String symbol) {
    if (symbol.isEmpty) return;
    
    if (verifyWhetherInstrumentIsAlreadyAdded(context, symbol)) {
      showInstrumentAddedMessageDialog(context);
      return;
    }
    
    Provider.of<UserProfileSecuritiesStore>(context, listen: false).addNewExchangeSecurityForUserProfileInstrumentAsync(symbol);
  }
  
  bool verifyWhetherInstrumentIsAlreadyAdded(BuildContext context, String symbol) {
    return Provider.of<UserProfileSecuritiesStore>(context, listen: false).all.any((security) => security.symbol == symbol);
  }
  
  void showInstrumentAddedMessageDialog(BuildContext context) {
    var okButton = TextButton(
      child: Text('OK', style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    
    var instrumentAddedMessageDialog = AlertDialog( 
      title: Text('Erro'),
      content: Text('Ativo já cadastrado.', style: TextStyle(fontSize: 16)),
      actions: [
        okButton,
      ],
    );
    
    showDialog(context: context, builder: (context) => instrumentAddedMessageDialog);
  }
  
  void showConfirmRemovalExchangeSecurityForUserProfileDialog(context, ExchangeSecurity security) {
    var cancelButton = TextButton(
      child: Text('Não', style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    
    var yesButton = TextButton(
      child: Text('Sim', style: TextStyle(fontSize: 16)),
      onPressed: () {
        removeExchangeSecurityForUserProfile(context, security);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${security.symbol} removido.', style: TextStyle(fontSize: 16))));
        Navigator.of(context).pop();
      },
    );
    
    var confirmRemovalExchangeSecurityForUserProfileDialog = AlertDialog(
      title: Text('Remover Ativo'),
      content: Text('Deseja realmente remover o ativo ${security.symbol}?', style: TextStyle(fontSize: 16)),
      actions: [
        cancelButton,
        yesButton,
      ],
    );
    
    showDialog(context: context, builder: (context) => confirmRemovalExchangeSecurityForUserProfileDialog);
  }
  
  void removeExchangeSecurityForUserProfile(BuildContext context, ExchangeSecurity security) {
    Provider.of<UserProfileSecuritiesStore>(context, listen: false).removeExchangeSecurityForUserProfileAsync(security);
  }
}