import 'package:electronic_store_app/adds.dart';
import 'package:flutter/material.dart';

class ProductAdds extends StatefulWidget {
  final String url;
  final String flat;
  final String name;
  final String catagory;
  final double price;
  final double width;
  final double height;

  ProductAdds({super.key, required this.url, required this.flat,
    required this.name, required this.catagory, required this.price,
    required this.width, required this.height,});

  @override
  State<ProductAdds> createState() => _ProductAddsState();
}

class _ProductAddsState extends State<ProductAdds> {



  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Adds(
              price: widget.price,
              catagory: widget.catagory,
              name: widget.name,
              url:widget.url
              )));
        },
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                margin: EdgeInsets.only(top: 20,left: 10),
                width:250,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade500, Colors.purple.shade500])
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.name,style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(widget.catagory,style: TextStyle(
                          color: Colors.white60,
                          fontSize: 18
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 150,bottom: 10),
                      child: Text('\$${widget.price.toString()}',style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 170,
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Text("\nFlat\n${widget.flat}%\n OFF",textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
                ),
              ),
            ),
            Image.asset(widget.url,width: widget.width,height: widget.height,)
          ],
        ),
      ),
    );
  }
}


class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    Path path = Path();
    path.moveTo(0, h * .33);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w*1.12, 0);
    path.quadraticBezierTo(w*.1,h*.25,0,h*.65);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
