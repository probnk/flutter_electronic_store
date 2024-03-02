import 'package:electronic_store_app/Cards.dart';
import 'package:electronic_store_app/History.dart';
import 'package:electronic_store_app/Login.dart';
import 'package:electronic_store_app/PaymentMethod.dart';
import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  List name = ['MyCards','Payment Method','History','Logout'];
  List pages = [MyCards(),PaymentMethod(),History()];
  List<IconData> icon = [
    Icons.credit_card_sharp,
    Icons.payments,
    Icons.history,
    Icons.logout
  ];

  bool _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleSignOut(BuildContext context) async {
    try{
      setState(() {
        _isLoading=true;
      });
      await _googleSignIn.signOut();
      if(_googleSignIn.currentUser== null){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>Login()));
      }
      await _auth.signOut();
      if(_auth.currentUser== null){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>Login()));
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade500, Colors.purple.shade500])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            ListView(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()));
                          },
                          icon: Icon(Icons.arrow_back_rounded,
                              size: 30, color: Colors.white)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings,
                              size: 30, color: Colors.white)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 100, top: 20),
                    child: Text(
                      'Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 160),
                    width: MediaQuery.of(context).size.width,
                    height: 610,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Text(
                            "Umar Farooq",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 5, bottom: 10),
                          child: Text(
                            "umarf3984@gmail.com",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                EdgeInsets.only(bottom: 20),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                )),
                            Container(
                              margin:
                              EdgeInsets.only(bottom: 20),
                              child: Text(
                                "Pakistan",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: () {
                                  if(index==3){
                                    _handleSignOut(context);
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>pages[index]));
                                  }
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    margin: EdgeInsets.only(left: 8,right: 8),
                                    width: MediaQuery.of(context).size.width,
                                    height: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(name[index],style: TextStyle(
                                            fontSize: 18
                                        ),
                                        ),
                                        Icon(icon[index])
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 100,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child:CircleAvatar(
                        radius: 70,
                        backgroundImage:AssetImage('assets/pic.jfif')
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if(_isLoading)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: CircularProgressIndicator()
                ),
              ),
          ]
        ),
      ),
    );
  }
}