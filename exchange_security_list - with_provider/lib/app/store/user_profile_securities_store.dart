import 'package:exchange_security_list/app/infra/generic_poller.dart';
import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';
import 'package:exchange_security_list/app/services/exchange_security/exchange_market_data_service_fake.dart';
import 'package:exchange_security_list/app/services/exchange_security/exchange_security_service.dart';
import 'package:exchange_security_list/app/services/user_profile/user_profile_service.dart';
import 'package:flutter/material.dart';

class UserProfileSecuritiesStore extends GenericPoller with ChangeNotifier {
  final List<ExchangeSecurity> _securities = [];
  final _userProfileService = UserProfileService();
  final _exchangeSecurityService = ExchangeSecurityService(ExchangeMarketDataServiceFake());
  
  List<String> instruments = [];
  List<ExchangeSecurity> securities = [];
  
  UserProfileSecuritiesStore() {
    getUserProfileAsync();
    super.start();
  }
  
  void getUserProfileAsync() async {
    instruments = await _userProfileService.getInstrumentsOfUserProfileAsync();
    securities = await _userProfileService.getUserProfileAsync();
    
    _securities.addAll(securities);
    
    notifyListeners();
  }

  List<ExchangeSecurity> get all {
    return [... _securities];
  }
  
  int get count {
    return _securities.length;
  }
  
  Future<void> addNewExchangeSecurityForUserProfileInstrumentAsync(String symbol) async {
    instruments.add(symbol);
    securities = await _exchangeSecurityService.createOrUpdateExchangeSecurityListForUserProfileInstrumentsAsync(instruments);
    
    _securities.replaceRange(0, all.length, securities);
    
    notifyListeners();
  }
  
  Future<void> removeExchangeSecurityForUserProfileAsync(ExchangeSecurity security) async {
    _securities.remove(security);
    instruments = await _userProfileService.setInstrumentsForUserProfileAsync(_securities);
    
    notifyListeners();
  }

  @override
  Future<void> startOrContinuePerformingUpdatingForExchangeSecurityListAsync() async {
    if (_securities.isEmpty) return;
    securities = await _exchangeSecurityService.createOrUpdateExchangeSecurityListForUserProfileInstrumentsAsync(instruments);
    
    _securities.setAll(0, securities);
    
    notifyListeners();
  }
}