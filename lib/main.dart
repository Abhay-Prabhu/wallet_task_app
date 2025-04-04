import 'package:flutter/material.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/features/wallet/view/wallet_screen.dart';
import 'package:provider/provider.dart';

import 'features/wallet/view_model/check_balance_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CheckBalance()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WalletScreen(),
    );
  }
}
