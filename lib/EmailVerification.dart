import 'dart:async';

import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _auth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  Timer? timer;
  bool _isLoading = false;
  EmailVerify() async {
    try{
      _auth.currentUser?.sendEmailVerification();
        timer = Timer.periodic(Duration(seconds: 5), (_) {
          _auth.currentUser?.reload();
          if(_auth.currentUser!.emailVerified)
            setState(() {
              isEmailVerified = _auth.currentUser!.emailVerified;
            });
        });
      if(isEmailVerified){
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  ContinueButton(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.only(left: 100,right: 100,top: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16
              ),
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
          onPressed: () {
          EmailVerify();
          },
          child: Text('Continue', style: TextStyle(
              color: Colors.white
          ),
          )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    EmailVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade500, Colors.purple.shade500])
      ),
      child:Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            ListView(
            children: [
              Image.asset("assets/logo.png", width: 180, height: 180,),
              Text("Electronic Store", textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
              ),
              Text("Shop Smarter not Harder", textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ),
              SizedBox(height: 70,),
              Text("Verify Your Email", textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,
                fontSize:30,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(height: 20,),
              Text(_auth.currentUser!.email!, textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.white,
                  fontSize:20,
              ),
              ),
              SizedBox(height: 50,),
              ContinueButton(context)
              ],
            ),
            if(_isLoading)
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black26,
                  child: Center(child: CircularProgressIndicator(),))
          ],
        ),
      ) ,
    );
  }
}