import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';
import 'package:v1/models/cart-items.dart';
import 'screens/login-screen.dart';
import 'screens/register-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:v1/screens/home-screen.dart';
import 'package:v1/screens/add-item-screen.dart';
import 'screens/item-screen.dart';
import 'screens/cart-screen.dart';
import 'screens/orders-screen.dart';
import 'screens/profile-screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Ver1());
}

// ignore: camel_case_types
class Ver1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(create: (_) => Auth(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<Auth>().authStateChanges),
        Provider<CartScreen>(
          create: (_) => CartScreen(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Nunito-Bold',
              primaryColor: Colors.black),
          debugShowCheckedModeBanner: false,
          home: AuthenticationWrapper(),
          routes: {
            '/home': (context) => Home(),
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/addItem': (context) => AddItem("", "", "", "", ""),
            '/itemScreen': (context) => ItemScreen(),
            '/cart': (context) => CartScreen(),
            '/orders':(context)=>OrdersScreen(),
            '/profile':(context)=>ProfileScreen(),
          }),
    );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Home();
    }
    return LoginScreen();
  }
}

class OnStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}