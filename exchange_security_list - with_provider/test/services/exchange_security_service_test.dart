import 'package:exchange_security_list/app/services/exchange_security/exchange_market_data_service_fake.dart';
import 'package:exchange_security_list/app/services/exchange_security/exchange_security_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeSecurityService', () {
    final _exchangeSecurityService = ExchangeSecurityService(ExchangeMarketDataServiceFake());
    List<String> instruments = ['BBDC4', 'ABEV3', 'PETR4', 'PETR3', 'VALE5', 'VALE3', 'BGIV21'];
    
    test('Deve criar uma lista de exchange security para os ativos do usuário', () async {
      final securities = await _exchangeSecurityService.createOrUpdateExchangeSecurityListForUserProfileInstrumentsAsync(instruments);
      
      bool securitiesSuccessfullyFilled  = true;
      for (int i = 0; i < securities.length; i++) {
        if (securities[i].symbol == null || securities[i].askPrice == null || securities[i].bidPrice == null || securities[i].price == null) {
          securitiesSuccessfullyFilled = false;
        }
      }
      
      expect(securitiesSuccessfullyFilled, true);
    });
  });
}