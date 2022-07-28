import 'package:exchange_security_list/app/routes/app_routes.dart';
import 'package:exchange_security_list/app/store/user_profile_securities_store.dart';
import 'package:exchange_security_list/app/views/edit_exchange_security_list_page.dart';
import 'package:exchange_security_list/app/views/exchange_security_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProfileSecuritiesStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.home: (_) => ExchangeSecurityListPage(),
          AppRoutes.editExchangeSecurityList: (_) => EditExchangeSecurityListPage(),
        },
      ),
    );
  }
}