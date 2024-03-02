import 'package:electronic_store_app/Products.dart';
import 'package:electronic_store_app/UserDetails.dart';
import 'package:electronic_store_app/bottomNavBar.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Product products;
  ProductDetails({super.key, required this.products});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  int items = 1;
  bool _isExpanded = false;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffa5e5f0),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (context)=>BottomNavBar()
                      )
                      );
                    },
                    icon: Icon(Icons.arrow_back_outlined,size: 30,)
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isTrue = !isTrue;
                    });
                  },
                  icon: isTrue
                      ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  )
                      : Icon(Icons.favorite_border),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child: Text('${widget.products.catagory}',style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('${widget.products.name}',style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
              ),
            ),
            Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(left: 100),
            child: Image.asset('${widget.products.url}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                    children:[
                      TextSpan(
                        text: 'Price\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                        ),
                      ),
                      TextSpan(

                        text: '\$${widget.products.price.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Color",style: TextStyle(color: Colors.grey,fontSize: 16)
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.yellow),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
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
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded=!_isExpanded;
                      });
                    },
                    children: [
                    ExpansionPanel(
                        headerBuilder: (BuildContext context,bool isExpanded){
                      return  Text("Description",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      );
                    },
                      body: Text(widget.products.description,style: TextStyle(
                      fontSize: 16,
                    ),
                    ),
                      isExpanded: _isExpanded
                    )
                    ],
                  ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(
                          height:50,width: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              onPressed: () => setState(() {
                                if(items>1){items--;}

                              }),
                              child: Text("-",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30
                              ),
                              )
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(items.toString(),style: TextStyle(
                          fontSize: 17,
                        ),),
                        SizedBox(width: 20,),
                        SizedBox(
                          height:50,width: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              onPressed: () => setState(() {
                                  items++;
                              }),
                              child: Text("+",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25
                              ),
                              )
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:EdgeInsets.symmetric(vertical: 20,horizontal: 35),
                              backgroundColor:Color(0xffa5e5f0),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                          onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>UserDetails(
                                            item: items,
                                            price: widget.products.price!,
                                            url: widget.products.url!,
                                            name: widget.products.name!,
                                            catagory: widget.products.catagory!)));
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$${(widget.products.price! * items).toStringAsFixed(2) }',
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}