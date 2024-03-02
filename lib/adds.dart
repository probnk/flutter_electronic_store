import 'package:electronic_store_app/UserDetails.dart';
import 'package:flutter/material.dart';

class Adds extends StatefulWidget {
  final double price;
  final String catagory;
  final String name;
  final String url;
  const Adds({super.key, required this.price, required this.catagory,
    required this.name, required this.url});

  @override
  State<Adds> createState() => _AddsState();
}

class _AddsState extends State<Adds> {
  bool favTrue = false;
  bool cartTrue = false;
int items =0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff61AEC7), Color(0xff484BAB)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('me.',style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              favTrue=!favTrue;
                            });
                          },
                          icon: favTrue
                              ? Icon(
                              Icons.favorite,
                              color: Colors.red.shade500,
                              size: 30
                          ):
                          Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 30
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              cartTrue=!cartTrue;
                            });
                          },
                          icon: cartTrue
                              ? Icon(
                              Icons.shopping_cart,
                              color: Colors.orange.shade400,
                              size: 30
                          ):
                          Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 30
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text("Color",style: TextStyle(color: Colors.white,fontSize: 16)
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0,top: 5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),
            SizedBox(width: 5,),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
            SizedBox(width: 5,),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
            )
          ],
        ),
      ),
            Stack(
              children: [
                    Transform.rotate(
                      angle: 19.2,
                      child: Container(
                        child:
                        Image.asset(widget.url,
                          width: 350,
                          height: 350,
                          scale: 1,
                        ),
                      ),
                    ),
                          Padding(
                            padding: const EdgeInsets.only(top: 310,left: 10),
                            child: Text(widget.catagory,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26
                              )
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 340,left: 10),
                      child: Text(widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 390,left: 20),
                  child: Text("Description",style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 410,left: 20),
                  child: Text('Our headsets are multitaskers that block noise and allow'
                      ' you to perform any number of tasks, even in a busy'
                      ' environment. ',style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  SizedBox(
                    height:50,width: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black45,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        onPressed: () => setState(() {
                          if(items>1){items--;}

                        }),
                        child: Text("-",style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                        ),
                        )
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(items.toString(),style: TextStyle(
                    fontSize: 17,
                    color: Colors.white
                  ),),
                  SizedBox(width: 20,),
                  SizedBox(
                    height:50,width: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black45,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        onPressed: () => setState(() {
                          items++;
                        }),
                        child: Text("+",style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                        )
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:EdgeInsets.symmetric(vertical: 20,horizontal: 35),
                      primary:Colors.black45,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails
                      (
                        item: items,
                        price: widget.price,
                        url: widget.url,
                        name: widget.name,
                        catagory: widget.catagory
                    )));
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${(widget.price*items).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("Buy Now",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_forward_ios,color: Colors.white38,),
                          Icon(Icons.arrow_forward_ios,color: Colors.white70,),
                          Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        ],
                      )
                    ],
                  )
              ),
            ),
           ]
        ),
      ),
    );
  }
}