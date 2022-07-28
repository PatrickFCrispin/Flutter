import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';
import 'package:exchange_security_list/app/models/user_settings/user_profile.dart';
import 'package:exchange_security_list/app/services/exchange_security/exchange_market_data_service_fake.dart';
import 'package:exchange_security_list/app/services/exchange_security/exchange_security_service.dart';

class UserProfileService {
  final _userProfile = UserProfile();
  final _exchangeSecurityService = ExchangeSecurityService(ExchangeMarketDataServiceFake());
  
  Future<List<String>> getInstrumentsOfUserProfileAsync() async {
    return _userProfile.subscribedInstruments = ['BBDC4', 'ABEV3', 'PETR4', 'PETR3', 'VALE5', 'VALE3', 'BGIV21'];
  }
  
  Future<List<ExchangeSecurity>> getUserProfileAsync() async {
    return _exchangeSecurityService.createOrUpdateExchangeSecurityListForUserProfileInstrumentsAsync(_userProfile.subscribedInstruments);
  }
  
  Future<List<String>> setInstrumentsForUserProfileAsync(List<ExchangeSecurity> securities) async {
    _userProfile.subscribedInstruments = [];
    
    for (int i = 0; i < securities.length; i++) {
      _userProfile.subscribedInstruments.add(securities[i].symbol.toString());
    }
    
    return _userProfile.subscribedInstruments;
  }
}