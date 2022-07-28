import 'dart:math';
import 'package:exchange_security_list/app/contracts/exchange_market_data_service.dart';
import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';

class ExchangeMarketDataServiceFake implements ExchangeMarketDataService {
  var random = Random();
  
  @override
  Future<ExchangeSecurity> getPropertiesOfExchangeSecurityForInstrumentAsync(String symbol) async {
    return ExchangeSecurity(
      symbol: symbol,
      askPrice: random.nextDouble().toString(),
      bidPrice: random.nextDouble().toString(),
      price: random.nextDouble().toString(),
    );
  }
}