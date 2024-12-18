import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/config/theme/light_theme.dart';
import 'package:portfolio/features/users/screens/user_list.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      // darkTheme: darkTheme,
      theme: lightTheme,
      title: "PortFolio",
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      'Couldn\'t check connectivity status: $e'.log();
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });

    bool stat = _connectionStatus[0] == ConnectivityResult.none;

    'Connectivity changed: ${_connectionStatus[0]}'.log();
    final snackBarMessage =
        stat ? "PLEASE CONNECT TO THE INTERNET" : "CONNECTED TO THE INTERNET";
    // final snackBarBackgroundColor = stat ? Colors.red[400] : Colors.green[400];

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          content: AwesomeSnackbarContent(
              title: snackBarMessage,
              message: '',
              contentType: stat ? ContentType.failure : ContentType.success),
          backgroundColor: Colors.transparent,
        ),
      );
  }

  bool isReloaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _connectionStatus[0] == ConnectivityResult.none
          ? Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    isReloaded = !isReloaded;
                  });
                },
                label: Text("Retry"),
                icon: Icon(Icons.replay_outlined),
              ),
            )
          : UserListScreen(),
    );
  }
}
