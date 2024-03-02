import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/HistoryItems.dart';
import 'package:electronic_store_app/UserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  List<HistoryItems> history  = [];
  List check = [];
  bool isSelected = false;
  bool Selected = false;

  void initState(){
    super.initState();
    FetchHistory();
  }

  Future FetchHistory()async {
    try{
      var data = await FirebaseFirestore.instance.collection('History')
          .doc(FirebaseAuth.instance.currentUser!.email!)
          .collection('Records')
          .get();
      setState(() {
        history = List.from(data.docs.map((doc) => HistoryItems.fromSnapshot(doc)));
      });
    }catch(e){
      print(e);
    }
  }
  listTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            bool selectedOption = item.fav ?? false;// Store the item at the current index
            return InkWell(
              onLongPress: () {
               setState(() {
                 isSelected = !isSelected;
               });
              },
              child: Stack(
                  children: [
                  Card(
                  color: Colors.grey.shade300,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                    Container(
                      margin: EdgeInsets.only(left: 200),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Image.asset('${item.url}',height: 150,width: 150,),
                  ),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('${item.catagory}',style: TextStyle(color: Colors.grey,fontSize: 16),),
                          Text('${item.user}',style: TextStyle(fontSize: 16)),
                          Text('0${item.phone}',style: TextStyle(fontSize: 16)),
                          Text('Price: ${item.price}',style: TextStyle(fontSize: 16)),
                          Text('Items: ${item.items}',style: TextStyle(fontSize: 16)),
                          Text('Total Price: ${item.total}',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ]
                      ),
                    )
                  ),
                    if(isSelected)
                      Stack(
                        children: [
                          Container(
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white24,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedOption = !selectedOption;
                              });
                              if(selectedOption){
                                check.add(item.name);
                              }
                              else if(!selectedOption){
                                check.remove(index);
                              }
                              item.fav = selectedOption;
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 300,top: 20),
                              padding: EdgeInsets.all(2),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 2),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child:Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: selectedOption || Selected ? Colors.black : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                              ) ,
                            ),
                          )
                        ]
                      )
                ]
              )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserProfile()));
                      },
                      icon: Icon(Icons.arrow_back,size: 30,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text("Order History",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: isSelected
                    ?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                        onPressed: () {
                         for(int i=0;i<=check.length;i++){
                           FirebaseFirestore.instance.collection('History')
                               .doc(FirebaseAuth.instance.currentUser!.email!)
                               .collection('Records')
                               .doc(check[i])
                               .delete();
                         }
                         history.removeAt(1);
                        },
                        child: Text('Delete')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        onPressed: () {
                          setState(() {
                            Selected = !Selected;
                          });
                        },
                        child: Text('Select All')),
                  ],
                ):Text('')
              ),
              Divider(thickness: 3,),
              listTile(context)
            ],
          )
      ),
    );
  }
}