import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class SettingsStore with ChangeNotifier {
  String _host = "127.0.0.1";
  String _port = "1883";
  String _topic = "topic/rabbit";
  String _name = "nannany";
  bool _isConnecting = false;
  bool _isConnected = false;

  void setHost(String host) {
    _host = host;
    notifyListeners();
  }

  void setPort(String port) {
    _port = port;
    notifyListeners();
  }

  void setTopic(String topic) {
    _topic = topic;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  String get getHost => _host;

  String get getPort => _port;

  String get getTopic => _topic;

  String get getName => _name;

  bool get isConnecting => _isConnecting;

  bool get isConnected => _isConnected;

  Future<void> connectMqttServer() async {
    _isConnecting = true;
    notifyListeners();

    int _targetPort = int.parse(_port);

    MqttServerClient _mqttClient =
        MqttServerClient.withPort(_host, _name, _targetPort);

    var mqttClientConnectionStatus = await _mqttClient.connect();

    var returnCode = mqttClientConnectionStatus.returnCode;
    print(returnCode);

    if (returnCode == MqttConnectReturnCode.connectionAccepted) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    _isConnecting = false;

    notifyListeners();
  }
}
