import 'package:exchange_security_list/app/contracts/exchange_market_data_service.dart';
import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';

class ExchangeSecurityService {
  late final ExchangeMarketDataService _exchangeMarketDataService;
  List<ExchangeSecurity> securities = [];
  
  ExchangeSecurityService(ExchangeMarketDataService exchangeMarketDataService) {
    _exchangeMarketDataService = exchangeMarketDataService;
  }
  
  Future<List<ExchangeSecurity>> createOrUpdateExchangeSecurityListForUserProfileInstrumentsAsync(List<String> instruments) async {
    securities = [];
    
    for (int i = 0; i < instruments.length; i++) {
      securities.add(await _exchangeMarketDataService.getPropertiesOfExchangeSecurityForInstrumentAsync(instruments[i]));
    }
    
    return securities;
  }
}