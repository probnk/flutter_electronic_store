class HistoryItems {
  String? name;
  String? catagory;
  String? url;
  String? email;
  String? address;
  String? user;
  String delivery = 'Free';
  String payment = 'Google Pay';
  double? price;
  double? total;
  int? items;
  int? phone;
  bool? fav;
  bool? cart;
  String description ='Lorem ipsum dolor sit amet consectetur adipisicing elit.'
      ' Sint pariatur accusantium, labore impedit officia iste reiciendis.'
      ' Aliquam fugiat vero beatae enim nesciunt amet nobis maxime non commodi,'
      ' impedit, unde vitae?';
  HistoryItems();

  Map<String,dynamic> toJson() => {'name':name,'catagory':catagory,'url':url,
    'email':email,'address':address,'user':user,'total':total,
    'phone':phone,'price':price,'items':items};

  HistoryItems.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        catagory = snapshot.data()['catagory'],
        url = snapshot.data()['url'],
        user = snapshot.data()['user'],
        email= snapshot.data()['email'],
        address = snapshot.data()['address'],
        total = snapshot.data()['total'],
        phone = snapshot.data()['phone'],
        items = snapshot.data()['items'],
        price = snapshot.data()['price'];
}