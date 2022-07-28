import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';
import 'package:exchange_security_list/app/services/user_profile/user_profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfileService', () {
    List<String> instruments = ['BBDC4', 'ABEV3', 'PETR4', 'PETR3', 'VALE5', 'VALE3', 'BGIV21'];
    final _userProfileService = UserProfileService();
    List<ExchangeSecurity> securities = [];
    
    test('Deve retornar os mesmos ativos da lista de ativos default do usuário', () async {      
      listEquals(instruments, await _userProfileService.getInstrumentsOfUserProfileAsync());
    });
    
    test('Deve retornar uma lista de exchange security para os ativos do usuário', () async {
      securities = await _userProfileService.getUserProfileAsync();
      
      bool securitiesSuccessfullyFilled  = true;
      for (int i = 0; i < securities.length; i++) {
        if (securities[i].symbol == null || securities[i].askPrice == null || securities[i].bidPrice == null || securities[i].price == null) {
          securitiesSuccessfullyFilled = false;
        }
      }
      
      expect(securitiesSuccessfullyFilled, true);
    });
    
    test('Deve atualizar a lista de ativos do usuário com a adição de um novo ativo', () async {
      String symbol = 'TF473';
      
      securities.add(ExchangeSecurity(
        symbol: symbol,
        askPrice: 0.toString(),
        bidPrice: 0.toString(),
        price: 0.toString(),
      ));
      
      instruments = await _userProfileService.setInstrumentsForUserProfileAsync(securities);
      
      expect(instruments.length, 8);
    });
  });
}