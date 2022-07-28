import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:exchange_security_list/app/contracts/exchange_market_data_service.dart';
import 'package:exchange_security_list/app/models/exchange_security/exchange_security.dart';

class ExchangeMarketDataServiceApi implements ExchangeMarketDataService {
  late final String baseUri;
  Dio dio = Dio();
  
  ExchangeMarketDataServiceApi(String baseUri) {
    this.baseUri = baseUri;
  }
  
  @override
  Future<ExchangeSecurity> getPropertiesOfExchangeSecurityForInstrumentAsync(String symbol) async {
    String uri = '$baseUri/?minify=false&t=webgateway&c=666&q=$symbol,1,1';
    var response = await dio.get(uri, options: Options(responseType: ResponseType.json));
    
    var responseDecoded = jsonDecode(response.data)['Value'];
    
    if (responseDecoded.isEmpty) {
      return ExchangeSecurity(
        symbol: symbol,
        askPrice: '-',
        bidPrice: '-',
        price: '-',
      );
    }
    
    return ExchangeSecurity.fromJson(responseDecoded[0]);
  }
}