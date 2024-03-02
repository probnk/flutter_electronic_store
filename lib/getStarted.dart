import 'package:electronic_store_app/Login.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade500,Colors.purple.shade500])
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 80,),
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Text("Welcome,",style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10,left: 70),
                child: Text("Find Your Gadgets",style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
             SizedBox(height: 20,),
             Container(
              margin: EdgeInsets.only(left: 30),
              child: Image(image: AssetImage("assets/getstarted.png")
                ,width: 300,height: 300,)
          ),
              Padding(
                padding: const EdgeInsets.only(left: 70,),
                child: Text("Get Start to Buy your Dreams",style: TextStyle(
                    color: Colors.white,
                    fontSize:18,
                ),
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 70,vertical: 20),
                      backgroundColor: Colors.black,
                      elevation: 8,
                      textStyle: TextStyle(
                        fontSize: 16
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),

                      onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(
                              builder: (context) => MainPage()
                            )
                          );
                      },
                      label: Text("Get Started"),
                      icon: Icon(Icons.arrow_right_alt,size: 30,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
