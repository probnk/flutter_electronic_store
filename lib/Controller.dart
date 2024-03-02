import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/Products.dart';
import 'package:electronic_store_app/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  List<Product> products = [];
  bool isLoading = true;
  final col = FirebaseFirestore.instance.collection('Favourite');
  final ref = FirebaseFirestore.instance.collection('Cart');
  final auth = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    fetchProductsFromFirestore();
  }

  Future fetchProductsFromFirestore() async {
    var data = await FirebaseFirestore.instance
        .collection('Controller')
        .orderBy('url',descending: false)
        .get();

    setState(() {
      products = List.from(data.docs.map((doc) => Product.fromSnapshot(doc)));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ?Center(child: CircularProgressIndicator(),)
          : GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.60,
        ),
        itemBuilder: (context, index) {
          final items = products[index];
          bool isFav = items.fav ?? false;
          bool isCart = items.cart ?? false;
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(products:items),
                ),
              );
            },
            child: Card(
              child: Container(
                width: 160,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${items.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${items.catagory}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('${items.url}'),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            items.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFav = !isFav; // Toggle the favorite state
                                  });
                                  if (isFav) {
                                    col
                                        .doc(auth)
                                        .collection('Items')
                                        .doc(items.name)
                                        .set({
                                      'name': items.name,
                                      'catagory': items.catagory,
                                      'url': items.url,
                                      'price': items.price,
                                      'fav': true,
                                    }).then((value) => print('Add'));
                                  } else {
                                    col
                                        .doc(auth)
                                        .collection('Items')
                                        .doc(items.name)
                                        .delete()
                                        .then((value) => print('remove'));
                                  }
                                  // Update the favorite state in the Product object
                                  items.fav = isFav;
                                },
                                icon: isFav
                                    ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                                    : Icon(Icons.favorite_border),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isCart = !isCart; // Toggle the favorite state
                                  });
                                  if (isCart) {
                                    ref
                                        .doc(auth)
                                        .collection('Items')
                                        .doc(items.name)
                                        .set({
                                      'name': items.name,
                                      'catagory': items.catagory,
                                      'url': items.url,
                                      'price': items.price,
                                      'cart': true,
                                    }).then((value) => print('Add'));
                                  } else {
                                    col
                                        .doc(auth)
                                        .collection('Items')
                                        .doc(items.name)
                                        .delete()
                                        .then((value) => print('remove'));
                                  }
                                  // Update the favorite state in the Product object
                                  items.cart = isCart;
                                },
                                icon: isCart
                                    ? Icon(Icons.shopping_basket, size: 30,color: Colors.orangeAccent,)
                                    : Icon(Icons.shopping_basket, size: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Review",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_half,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.orangeAccent,
                            size: 15,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}