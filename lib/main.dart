import 'package:flutter/material.dart';
import 'package:ZBM_TASK01/UI Screens/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'Notifier/login_state.dart'; // Import your LoginState
import 'Notifier/register_state.dart';
import 'api_client.dart'; // Import your RegisterState

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginState(), // Providing LoginState
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterState(), // Providing RegisterState
        ),
          ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) => MaterialApp(
        title: 'ZBMTECH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff4C53FB),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
