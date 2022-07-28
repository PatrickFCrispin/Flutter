abstract class GenericPoller {
  bool running = false;
  static const defaultPollingIntervalMs = 2000;
  
  void start() {
    if (running) return;
    
    running = true;
    delayThenStartOrContinuePollingActionAsync();
  }
  
  Future<void> delayThenStartOrContinuePollingActionAsync() async {
    await Future.delayed(Duration(milliseconds: defaultPollingIntervalMs), () async {
      await startOrContinuePerformingUpdatingForExchangeSecurityListAsync();
      print('ok');
      pulse();
    });
  }
  
  Future<void> startOrContinuePerformingUpdatingForExchangeSecurityListAsync();
  
  void pulse() {
    if (!running) return;
    
    delayThenStartOrContinuePollingActionAsync();
  }
  
  void stop() {
    if (!running) return;
    
    running = false;
  }
}