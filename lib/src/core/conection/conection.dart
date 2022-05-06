abstract class Network {
  bool get isConnect;
}

class NetorkImpl implements Network {
  final bool connectionChecker;

  NetorkImpl(this.connectionChecker);
  @override
  bool get isConnect {
    return connectionChecker;
  }
}
