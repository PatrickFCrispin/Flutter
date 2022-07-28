import 'package:exchange_security_list/app/services/exchange_security/exchange_market_data_service_fake.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeMarketDataService', () {
    final _exchangeMarketDataService = ExchangeMarketDataServiceFake();
    String symbol = 'TF473';
    
    test('Deve gerar e preencher a cotação para um ativo', () async {
      final exchangeSecurity = await _exchangeMarketDataService.getPropertiesOfExchangeSecurityForInstrumentAsync(symbol);
      
      bool exchangeSecuritySuccessfullyFilled  = true;
      if (exchangeSecurity.symbol != symbol || (exchangeSecurity.symbol == null || exchangeSecurity.askPrice == null || exchangeSecurity.bidPrice == null || exchangeSecurity.price == null)) {
        exchangeSecuritySuccessfullyFilled = false;
      }
      
      expect(exchangeSecuritySuccessfullyFilled, true);      
    });
  });
}