import 'package:electronic_store_app/EmailVerification.dart';
import 'package:electronic_store_app/OTPVerification.dart';
import 'package:electronic_store_app/Signup.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText = true;
  bool _isLoading = false;
  final _googlesignin = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  final _key = GlobalKey<FormState>();
  final otp = EmailOTP();

  //User Email TextField
  EmailTextField(){
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: email,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Email',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.mail, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        validator: (String? value){
          if(value!.isEmpty){
            return 'Please Enter Your Email';
          }
          return null;
        },
      ),
    );
  }

  //User Email Password TextField
  PasswordTextField(){
    return   Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: password,
        style: TextStyle(color: Colors.white),
        obscureText: _obscureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Password',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: _obscureText ?
              Icon(Icons.visibility_off, color: Colors.white,)
                  : Icon(
                Icons.visibility, color: Colors.white,),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        validator: (String? value){
          if(value!.isEmpty){
            return 'Please Enter Your Password';
          }
          return null;
        },
      ),
    );
  }

  //User Signin Button
  SignInButton(){
    return  ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
                fontSize: 16
            ),
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        onPressed: () {
          if(!_key.currentState!.validate()){
            return ;
          }
          else{
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>VerifyOTP(email:email.text,pass:password.text)));
          }
        },
        child: Text("Signin", style: TextStyle(
            color: Colors.white
        ),
        )
    );
  }

  //User got to the SignUp Screen if not have account
  SignUpScreen(){
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Do you have an account?", style: TextStyle(
          color: Colors.white,
        ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Signup()
              )
              );
            },
            child: Text("Signup Now", style: TextStyle(
              color: Colors.white,
            ),
            )
        )
      ],
    );
  }

  //User Signin through his Google gmail
  GoogleButton(){
    return   Padding(
      padding: const EdgeInsets.only(left: 50,right: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 7,
              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              )
          ),
          onPressed: (){
            _handleSignIn(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/google.png",height: 25,width: 25,),
              Text("   Google",style: TextStyle(
                  fontSize: 20,
                  color:Colors.black
              ),
              )
            ],
          )
      ),
    );
}

  Future _handleSignIn(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await _googlesignin.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail()));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  //User can Signin through his Facebook Account
  FacebookButton(){
    return Padding(
      padding: const EdgeInsets.only(left: 50,right: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 8,

              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              )
          ),
          onPressed: (){
          },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook,
                color: Colors.white,
                size: 30,),
              Text("     Facebook",style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
              )
            ],
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
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                ListView(
                children: [
                  Column(
                    children: [
                      Image.asset("assets/logo.png", width: 180, height: 180,),
                      Text("Electronic Store", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      Text("Shop Smarter not Harder", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      ),
                      SizedBox(height: 20,),
                      Form(
                        key: _key,
                          child:Column(
                            children: [
                              EmailTextField(),
                              SizedBox(height: 5,),
                              PasswordTextField(),
                            ],
                          )
                      ),

                      SizedBox(height: 20,),

                      SignInButton(),

                      SizedBox(height: 5,),

                      SignUpScreen(),

                      Text("----------------------------------OR----------------------------------",
                        style: TextStyle(
                        color: Colors.white,
                       ),
                      ),

                      SizedBox(height:20),

                      GoogleButton(),

                      SizedBox(height:10),

                      FacebookButton()
                      ],
                    )
                  ],
                ),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator()
                    ),
                  ),
              ]
            )
        )
    );
  }
}