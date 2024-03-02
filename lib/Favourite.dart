import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/Products.dart';
import 'package:electronic_store_app/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool isTrue = true;
  final auth = FirebaseAuth.instance.currentUser?.email;
  List<Product> product = [];
  final col = FirebaseFirestore.instance.collection('Favourite');

  @override
  void initState(){
    super.initState();
    FetchFavourite();
  }

  Future FetchFavourite()async {
    try{
      var data = await FirebaseFirestore.instance.collection('Favourite')
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
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>ProductDetails(
                                products: item)
                        ));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                child: ListTile(
                  leading: Image.asset('${item.url}'),
                  title:Text('${item.name}') ,
                  subtitle: Text('${item.catagory}'),
                  trailing: IconButton(
                          onPressed: () {
                            col
                                .doc(auth)
                                .collection('Items')
                                .doc(item.name)
                                .delete().then((value) => print('remove'));
                            setState(() {
                              product.remove(item.name);
                            });
                          },
                          icon:  item.fav!
                              ? Icon(Icons.favorite,color: Colors.redAccent,)
                              :Icon(Icons.favorite_border)
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
              Text("Favourite Items",textAlign: TextAlign.center,
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