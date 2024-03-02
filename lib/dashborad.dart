import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.home_filled,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("Home",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.group,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("Friends",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.contacts,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("Contacts",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.favorite,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("Favourite",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Divider(color: Colors.black12),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.facebook,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("FaceBook",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.adb,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text("Android",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.youtube_searched_for,
                        size: 30,
                        color: Colors.grey
                    ),
                    SizedBox(width: 10,),
                    Text("Youtube",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.help,
                        size: 30,
                        color: Colors.grey
                    ),
                    SizedBox(width: 10,),
                    Text("Help",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
