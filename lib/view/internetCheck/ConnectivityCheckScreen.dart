import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityCheckScreen extends StatefulWidget {
  const ConnectivityCheckScreen({super.key});

  @override
  _ConnectivityCheckScreenState createState() =>
      _ConnectivityCheckScreenState();
}

class _ConnectivityCheckScreenState extends State<ConnectivityCheckScreen> {
  String _connectivityStatus = "Checking connectivity...";
  late final Connectivity _connectivity;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _listenToConnectivityChanges();
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    String status;
    switch (result) {
      case ConnectivityResult.mobile:
        status = "Connected to Mobile Data";
        break;
      case ConnectivityResult.wifi:
        status = "Connected to WiFi";
        break;
      case ConnectivityResult.ethernet:
        status = "Connected via Ethernet";
        break;
      case ConnectivityResult.none:
        status = "No Internet Connection";
        break;
      default:
        status = "Unknown Connection";
    }
    setState(() {
      _connectivityStatus = status;
    });
  }

  void _listenToConnectivityChanges() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Internet Connectivity Check"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _connectivityStatus,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
