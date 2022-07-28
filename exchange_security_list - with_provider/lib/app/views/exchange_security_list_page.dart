import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';
import 'package:exchange_security_list/app/routes/app_routes.dart';
import 'package:exchange_security_list/app/store/user_profile_securities_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeSecurityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProfileSecuritiesStore _userProfileSecuritiesStore = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos'),
        actions: <Widget>[
          TextButton(
            child: Text('Editar', style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () {
              _userProfileSecuritiesStore.stop();
              Navigator.of(context).pushNamed(AppRoutes.editExchangeSecurityList, arguments: _userProfileSecuritiesStore.all).then((value) {
                _userProfileSecuritiesStore.start();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: _createColumns(),
            rows: _userProfileSecuritiesStore.all.map((security) => _createRows(security)).toList(),
            dataRowHeight: 65,
          ),
        ),
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
  
  DataRow _createRows(ExchangeSecurity security) {
    return DataRow(
      cells: [
        DataCell(Text(security.symbol.toString())),
        DataCell(Text(security.price.toString())),
        DataCell(Text(security.askPrice.toString())),
        DataCell(Text(security.bidPrice.toString())),
      ],
    );
  }
}