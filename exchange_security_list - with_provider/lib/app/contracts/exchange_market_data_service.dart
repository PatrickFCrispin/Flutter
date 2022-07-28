import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';

abstract class ExchangeMarketDataService {
  Future<ExchangeSecurity> getPropertiesOfExchangeSecurityForInstrumentAsync(String symbol);
}