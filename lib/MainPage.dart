import 'package:electronic_store_app/Login.dart';
import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return BottomNavBar();
              }
              else{
                return Login();
              }
            }
           return Center(child: CircularProgressIndicator(),);
          },
      )
    );
  }
}
