import 'package:exchange_security_list/app/store/user_profile_securities_store.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('UserProfileSecuritiesStore', () {
    final _userProfileSecuritiesStore = UserProfileSecuritiesStore();
    
    test('Deve adicionar um exchange security para um ativo', () async {
      String symbol = 'TF473';
      await _userProfileSecuritiesStore.addNewExchangeSecurityForUserProfileInstrumentAsync(symbol);
      
      expect(_userProfileSecuritiesStore.all.length, 8);
    });
    
    test('Deve remover um exchange security', () {
      _userProfileSecuritiesStore.removeExchangeSecurityForUserProfileAsync(_userProfileSecuritiesStore.securities[0]);
      
      expect(_userProfileSecuritiesStore.all.length, 7);
    });
  });
}