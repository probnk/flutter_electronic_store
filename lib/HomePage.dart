import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_store_app/Camera.dart';
import 'package:electronic_store_app/Controller.dart';
import 'package:electronic_store_app/Earbuds.dart';
import 'package:electronic_store_app/Headset.dart';
import 'package:electronic_store_app/KeyBoard.dart';
import 'package:electronic_store_app/MicroPhone.dart';
import 'package:electronic_store_app/Mouse.dart';
import 'package:electronic_store_app/PlayStation.dart';
import 'package:electronic_store_app/ProductAdds.dart';
import 'package:electronic_store_app/Speaker.dart';
import 'package:electronic_store_app/Xbox.dart';
import 'package:electronic_store_app/drawer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int activeIndex = 0;

  Appbar(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            IconButton(
                onPressed: () {
                  drawer();
                  },
                icon: Icon(Icons.more_vert,size: 40,)
            ),
          Text("Electronic Store",style: TextStyle(
              fontSize: 24,
             fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                  },
                  icon:  Icon(Icons.document_scanner,size: 25,)
              ),
              IconButton(
                  onPressed: () {},
                  icon:  Icon(Icons.shopping_bag_outlined,size: 25,)
              ),
            ],
          )
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5,left: 4,right: 10,bottom: 10),
              height:45,
              width: 290,
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.black
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.black,size: 27,),
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black,width: 1.5)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black,width: 1.5)
                    )
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.mic,size: 30,),
            )
          ],
        ),
      ],
    );
  }

  Catagories(){
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 5,right: 5),
      child: ButtonsTabBar(
        splashColor: Colors.cyan,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade500, Colors.purple.shade500])
          ),
          physics: ClampingScrollPhysics(),
          elevation: 5,
          radius: 20,
          unselectedBackgroundColor: Colors.white,
          height: 55,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          tabs: [
            Tab(text: 'Headset',icon: Icon(Icons.headphones),),
            Tab(text: 'Speaker',icon: Icon(Icons.speaker),),
            Tab(text: 'Earbuds',icon: Icon(Icons.earbuds),),
            Tab(text: 'Controller',icon: Icon(Icons.control_camera),),
            Tab(text: 'Play Station',icon: Icon(Icons.gamepad),),
            Tab(text: 'Xbox',icon: Icon(Icons.gamepad_outlined),),
            Tab(text: 'Mouse',icon: Icon(Icons.mouse),),
            Tab(text: 'Keyboard',icon: Icon(Icons.keyboard),),
            Tab(text: 'Camera',icon: Icon(Icons.camera_alt),),
            Tab(text: 'MicroPhone',icon: Icon(Icons.mic),),

          ]),
    );
  }

  Items(){
    return SizedBox(
        height: MediaQuery.of(context).size.height - 340,
      
      child:TabBarView(
          children: [
            Headset(),
            Speaker(),
            Earbuds(),
            Controller(),
            PlayStation(),
            Xbox(),
            Mouse(),
            Keyboard(),
            Camera(),
            Microphone()
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 10,
        child: ListView(
          children: [
            Appbar(),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5),
              child: Text("Big Sale",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),
              ),
            ),
            SizedBox(height: 8,),
            CarouselSlider(
              items:[
                ProductAdds(
                    url: 'assets/headset1.png',
                    flat: '30',
                    name: 'Logitech G Pro',
                    catagory: 'Gaming Headset',
                    price: 49.99,
                    width: 200,
                    height: 200
                ),
                ProductAdds(
                    url: 'assets/speaker1.png',
                    flat: '33',
                    name: 'Sony Mini Speaker',
                    catagory: 'SRS-XB10',
                    price: 24.99,
                    width: 170,
                    height: 170),
                ProductAdds(
                    url: 'assets/airbud1.png',
                    flat: '30',
                    name: 'Logitech Zone True',
                    catagory: 'BLuetooth/Wireless',
                    price: 54.99,
                    width: 180, height: 180,),
                ProductAdds(
                    url: 'assets/controller1.png',
                    flat: '30',
                    name: 'Sony DualShock4',
                    catagory: 'Wireless',
                    price: 68.99,
                    height: 150,
                    width: 150,
                ),
                ProductAdds(
                    url: 'assets/ps5.png',
                    flat: '30',
                    name: 'PlayStation 5',
                    catagory: 'Gaming Box',
                    price: 299.99,
                    width: 200,
                    height: 150,
                ),
                ProductAdds(
                    url: 'assets/xbox x series.png',
                    flat: '30',
                    name: 'Xbox X Series',
                    catagory: 'Gaming Console',
                    price: 249.99,
                    width: 180,
                    height: 180
                ),
                ProductAdds(
                    url: 'assets/mouse1.png',
                    flat: '30',
                    name: 'Logitech G502 Hero',
                    catagory: 'Gaming Mouse',
                    price: 39.99,
                    width: 200,
                    height: 200
                ),
                ProductAdds(
                    url: 'assets/keyboard1.png',
                    flat: '30',
                    name: 'Logitech G413',
                    catagory: 'Mechenical Keyboard',
                    price: 84.99,
                    width: 150,
                    height: 180),
                ProductAdds(
                    url: 'assets/camera1.png',
                    flat: '30',
                    name: 'GoPro Hero 6',
                    catagory: 'Camera',
                    price: 199.99,
                    width: 130,
                    height: 160
                ),
                ProductAdds(
                    url: 'assets/mic1.png',
                    flat: '30',
                    name: 'Rode NT-1-A',
                    catagory: 'PodMic',
                    price:129.99,
                    width: 180,
                    height: 150
                ),
              ],
              options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds:800),
                  viewportFraction: 0.75,
                  onPageChanged: (index,reason){
                    setState(() {
                      activeIndex = index;
                    });
                  }
              ),
            ),
            SizedBox(height: 10,),
            Center(
                child:
                AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: 10,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue.shade900,
                      dotHeight: 12,
                      dotWidth: 12
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 220,top: 10),
              child: Text("Catagories",style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.bold
              ),
              ),
            ),
            Catagories(),
            Items(),
          ],
        ),
      ),
    );
  }
}
