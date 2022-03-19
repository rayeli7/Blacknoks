import 'package:blacknoks/pages/splashscreen.dart';
import 'package:blacknoks/services/connectivity_provider.dart';
import 'package:blacknoks/services/livedata_provider.dart';
import 'package:flutter/material.dart';
import 'package:blacknoks/services/auth_service.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/home.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'services/asset_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<LiveProvider>(
          create: (_)=> LiveProvider()
        ),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_)=> ConnectivityProvider()
        ),
        ChangeNotifierProvider<AssetProvider>(
          create: (_)=> AssetProvider()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'loading': (_) => const LoadingPage(),
          '/home': (context) => const Homepage(),
        },
        // Application name
        title: 'Blacknoks',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // A widget which will be started on application startup
        home: const SplashScreen(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      return const Homepage();
    }
    return const LoginPage();
  }
}
