import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/Products.dart';
import 'package:electronic_store_app/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isTrue = true;
  final auth = FirebaseAuth.instance.currentUser?.email;
  List<Product> product = [];
  final col = FirebaseFirestore.instance.collection('Cart');

  @override
  void initState(){
    super.initState();
    FetchCart();
  }

  Future FetchCart()async {
    try{
      var data = await FirebaseFirestore.instance.collection('Cart')
          .doc(auth)
          .collection('Items')
          .get();
      setState(() {
        product = List.from(data.docs.map((doc) => Product.fromSnapshot(doc)));
      });
    }catch(e){
      print(e);
    }
  }

  listTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            final item = product[index]; // Store the item at the current index
            return  InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ProductDetails(
                        products: item)));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
                  child: ListTile(
                    leading: Image.asset('${item.url}'),
                    trailing: IconButton(
                        onPressed: () {
                          col
                              .doc(auth)
                              .collection('Items')
                              .doc(item.name)
                              .delete().then((value) => print('remove'));
                        },
                        icon:  item.cart!
                            ? Icon(Icons.shopping_cart,color: Colors.orangeAccent,)
                            :Icon(Icons.shopping_cart_outlined)

                    ),
                    title: Text('${item.name}'),
                    subtitle: Text('\$${item.price}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:ListView(
            children: [
              Text("Cart Items",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  )
              ),
              Divider(thickness: 3,),
              listTile(context)
            ],
          )
      ),
    );
  }
}