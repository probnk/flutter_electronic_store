import 'package:electronic_store_app/Login.dart';
import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyOTP extends StatefulWidget {
  final String email;
  final String pass;
  const VerifyOTP({super.key, required this.email, required this.pass});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {

  final otp = TextEditingController();
  final emailOTP = EmailOTP();
  bool _isLoading = false;
  bool otpverify = false;

  @override
  void initState() {
    super.initState();
    sendOTP();
  }

  OTPTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        controller: otp,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter OTP',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'OTP',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.code_sharp, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6)
        ],
        validator: (String? value){
          if(value!.isEmpty){
            return 'Please Enter OTP';
          }
          else if(value.length != 6){
            return 'Please Enter Exact 6 Digits';
          }
          return null;
        },
      ),
    );
  }

  void sendOTP() async {
      emailOTP.setConfig(
          appEmail: "umarf3984@gmail.com",
          appName: "Check",
          userEmail: widget.email,
          otpLength: 6,
          otpType: OTPType.digitsOnly
      );
      if (await emailOTP.sendOTP() == true) {
       Fluttertoast.showToast(msg: 'OTP Send Successfully');
      } else {
        Fluttertoast.showToast(msg: 'OTP Not Send');
      }
  }

  Future signin() async {
    try {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth _auth = await FirebaseAuth.instance;
      await _auth.signInWithEmailAndPassword(
          email: widget.email,
          password: widget.pass);
      if (_auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>BottomNavBar()));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  OTPButton(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.only(left: 100,right: 100,top: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16
              ),
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
          onPressed: () async {
            if (await emailOTP.verifyOTP(otp: otp.text) == true) {
              signin();
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("Invalid OTP"),
              ));
            }
          },
          child: Text('Verify', style: TextStyle(
              color: Colors.white
          ),
          )
      ),
    );
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
              Text("Electronic Store",textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
              ),
              Text("Shop Smarter not Harder",textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ),
              SizedBox(height: 50,),
              Text("OTP\nVerfication",textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
              ),
              OTPTextField(),
              SizedBox(height: 30,),
              OTPButton(context)
               ],
            ),
            if(_isLoading)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black26,
                  child: Center(child: CircularProgressIndicator(),))
          ]
        ),
      ) ,
    );
  }
}