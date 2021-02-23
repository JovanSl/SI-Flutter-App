import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/db/auth.dart';
import 'screens/login-screen.dart';
import 'screens/register-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:v1/screens/home-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ver1());
}

class ver1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MultiProvider(providers: [
      Provider<Auth>(create:(_)=>Auth(FirebaseAuth.instance),
      ),
      StreamProvider(create:(context)=>context.read<Auth>().authStateChanges)
    ],
    child:MaterialApp(
      home: AuthenticationWrapper(),
            routes: {
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
          }),
    );
        }
      }
      
      class AuthenticationWrapper extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          final firebaseUser=context.watch<User>();
          if(firebaseUser != null){
            return Home();
          }
          return LoginScreen();
        }
      }