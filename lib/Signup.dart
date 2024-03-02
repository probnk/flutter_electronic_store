import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isLoading = false;
  String? _uid;
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final  confirm= TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
  }

  //User FullName TextField
  FullNameTextField(){
    return  Padding(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: TextFormField(
        controller: name,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Full Name',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Full Name',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.person, color: Colors.white,),
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
            return 'Please Enter Your Name';
          }
          return null;
        },
      ),
    );
  }

  //User Email TextField
  EmailTextField(){
    return  Padding(
      padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: password,
        style: TextStyle(color: Colors.white),
        obscureText: _obscureText1,
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
                  _obscureText1 = !_obscureText1;
                });
              },
              icon: _obscureText1 ?
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

  //Confirm User Email Password TextField
  ConfirmPasswordTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: confirm,
        style: TextStyle(color: Colors.white),
        obscureText: _obscureText2,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Confirm Password',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
              icon: _obscureText2 ?
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
            return 'Please Enter Your Confirm Password';
          }
          return null;
        },
      ),
    );
  }

  //Signup User Account For Electronic Store
  SignUpButton(){
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
            signup();
          }
        },
        child: Text("Signup", style: TextStyle(
            color: Colors.white
        ),
        )
    );
  }

  //if user have already account then navigate to Signin screen for user login
  NavigateToSignInScreen(){
    return    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Do you have already account?", style: TextStyle(
          color: Colors.white,
        ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login()
              )
              );
            },
            child: Text("Login Now", style: TextStyle(
              color: Colors.white,
            ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                          child: Column(
                        children: [
                          FullNameTextField(),
                          SizedBox(height: 5,),
                          EmailTextField(),
                          SizedBox(height: 5,),
                          PasswordTextField(),
                          SizedBox(height: 15,),
                          ConfirmPasswordTextField(),
                          ],
                        )
                      ),

                      SizedBox(height: 20,),

                      SignUpButton(),

                      SizedBox(height: 5,),

                      NavigateToSignInScreen()
                      ],
                    )
                  ],
                ),
                if(_isLoading)
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
  Future signup() async {
    try {
      setState(() {
        _isLoading = true;
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      ).then((userCredential) {
        _uid = userCredential.user!.uid;
        Fluttertoast.showToast(
          msg: 'Signup Successfully',
          backgroundColor: Colors.grey,
        );

        CollectionReference _reference =
        FirebaseFirestore.instance.collection('Users');
        _reference.doc(_uid).set({
          'Email': email.text,
          'Name': name.text,
          'Password': password.text,
        });
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }}