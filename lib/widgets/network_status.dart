// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// // 1. Define a Connectivity Provider to manage network state
// final connectivityProvider = FutureProvider<ConnectivityResult>((ref) async {
//   final connectivity = Connectivity();
//   return await connectivity.checkConnectivity(); // Get current connectivity
// });

// // 2. Create a Stateful Widget to listen to connectivity changes
// class NetworkCheckWidget extends ConsumerStatefulWidget {
//   @override
//   _NetworkCheckWidgetState createState() => _NetworkCheckWidgetState();
// }

// class _NetworkCheckWidgetState extends ConsumerState<NetworkCheckWidget> {
//   @override
//   void initState() {
//     super.initState();
//     _listenToConnectivityChanges();
//   }

//   // Listen to real-time connectivity changes
//   void _listenToConnectivityChanges() {
//     final connectivity = Connectivity();
//     connectivity.onConnectivityChanged.listen((connectivityResult) {
//       _handleConnectivityChange(connectivityResult);
//     });
//   }

//   // Handle changes in connectivity
//   void _handleConnectivityChange(ConnectivityResult result) {
//     final snackBarMessage = result == ConnectivityResult.none
//         ? "PLEASE CONNECT TO THE INTERNET"
//         : "CONNECTED TO THE INTERNET";
//     final snackBarBackgroundColor =
//         result == ConnectivityResult.none ? Colors.red[400] : Colors.green[400];

//     // Show a snackbar based on the connection status
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(snackBarMessage),
//         backgroundColor: snackBarBackgroundColor,
//         duration: Duration(days: result == ConnectivityResult.none ? 1 : 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final connectivityResult =
//         ref.watch(connectivityProvider); // Watch the connectivity provider

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Network Check Example"),
//       ),
//       body: connectivityResult.when(
//         data: (connectivity) {
//           return Center(
//             child: Text(
//               connectivity == ConnectivityResult.none
//                   ? "No Internet Connection"
//                   : "Connected to the Internet",
//               style: TextStyle(fontSize: 20),
//             ),
//           );
//         },
//         loading: () =>
//             Center(child: CircularProgressIndicator()), // Show loading state
//         error: (error, stackTrace) =>
//             Center(child: Text('Error: $error')), // Show error
//       ),
//     );
//   }
// }
