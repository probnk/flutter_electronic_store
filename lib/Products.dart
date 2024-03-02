class Product {
  String? name;
  String? catagory;
  String? url;
  double? price;
  bool? fav;
  bool? cart;
  String description ='Lorem ipsum dolor sit amet consectetur adipisicing elit.'
      ' Sint pariatur accusantium, labore impedit officia iste reiciendis.'
      ' Aliquam fugiat vero beatae enim nesciunt amet nobis maxime non commodi,'
      ' impedit, unde vitae?';
  Product();

  Map<String,dynamic> toJson() => {'name':name,'catagory':catagory,'url':url,'price':price,'fav':fav,'cart':cart};

  Product.fromSnapshot(snapshot)
  : name = snapshot.data()['name'],
    catagory = snapshot.data()['catagory'],
    url = snapshot.data()['url'],
    price = snapshot.data()['price'],
    fav = snapshot.data()['fav'],
    cart= snapshot.data()['cart'];
}