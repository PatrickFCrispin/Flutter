class ExchangeSecurity {
  String? symbol;
  String? askPrice;
  String? bidPrice;
  String? price;
  
  ExchangeSecurity({this.symbol, this.askPrice, this.bidPrice, this.price});
  
  ExchangeSecurity.fromJson(Map<String, dynamic> json) {
    symbol = json['Symbol'];
    askPrice = json['Properties']['AskPrice'] ?? '-';
    bidPrice = json['Properties']['BidPrice'] ?? '-';
    price = json['Properties']['Price'] ?? '-';
  }
}