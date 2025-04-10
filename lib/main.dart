import 'package:flutter/material.dart';
import 'package:match_maker/core/services/local_storage.dart';
import 'package:match_maker/features/wallet/view_model/redeem_detail_provider.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/otp_provider.dart';
import 'package:match_maker/features/wallet/view_model/otp_timer_provider.dart';
import 'package:match_maker/features/wallet/view_model/save_payment_model.dart';
import 'package:provider/provider.dart';
import 'features/auth/views/splash_screen.dart';
import 'features/wallet/view_model/check_balance_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RedeemDetailsProvider()),
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => SavePaymentProvider()),
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => CheckBalance()),
      ChangeNotifierProvider(create: (context) => OtpProvider()),
      ChangeNotifierProvider(create: (context) => OTPTimerProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const HomeInitializer());
  }
}

class HomeInitializer extends StatefulWidget {
  const HomeInitializer({super.key});

  @override
  State<HomeInitializer> createState() => _HomeInitializerState();
}

class _HomeInitializerState extends State<HomeInitializer> {
  final FToast fToast = FToast();
  bool _isToastInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isToastInitialized) {
      fToast.init(context);
      _isToastInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
