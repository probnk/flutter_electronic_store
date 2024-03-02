import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_store_app/Order.dart';
import 'package:electronic_store_app/payment_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

class UserDetails extends StatefulWidget {
  final int item;
  final double price;
  final String url;
  final String name;
  final String catagory;
  UserDetails({super.key, required this.item, required this.price,
    required this.url, required this.name, required this.catagory});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController email = TextEditingController();
  TextEditingController postal = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController cardholder = TextEditingController();
  int step= 0;
  int? selectedIndex;
  String? bank;
  DateTime? time;

  var ApplePay = ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems:  [
        PaymentItem(
            label: 'Item A',
            amount:'0.01',
            status: PaymentItemStatus.final_price
        ),
        PaymentItem(
            label: 'Item B',
            amount:'0.01',
            status: PaymentItemStatus.final_price
        ),
        PaymentItem(
            label: 'Total',
            amount:'0.02',
            status: PaymentItemStatus.final_price
        ),
      ],
    style: ApplePayButtonStyle.black,
    width: 200,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: EdgeInsets.only(left: 50,right: 50),
    onPaymentResult: (result) => debugPrint('Payment : $result'),
    loadingIndicator: Center(child: CircularProgressIndicator(),),
  );

  var GooglePay = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems:[
      PaymentItem(
          label: 'Total',
          amount:'0.02',
          status: PaymentItemStatus.final_price
      ),
    ],
    width: 200,
    height: 50,
    type:GooglePayButtonType.pay,
    margin: EdgeInsets.only(left: 50,right: 50),
    onPaymentResult: (result) => debugPrint('Payment : $result'),
    loadingIndicator: Center(child: CircularProgressIndicator(),),
  );


  FullNameTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        autofocus: true,
        controller: user,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withAlpha(80),
          hintText: 'Enter Your Full Name',
          hintStyle: TextStyle(
              color: Colors.white
          ),
          labelText: 'Name',
          labelStyle: TextStyle(
              color: Colors.white
          ),
          suffixIcon: Icon(Icons.person, color: Colors.white,),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white)
          ),
        ),
        keyboardType: TextInputType.name,
        validator: (value){
          if(value!.isEmpty){
            return 'Please Enter Your Name';
          }
          return null;
        },
      ),
    );
  }
  EmailTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
      child: TextFormField(
        autofocus: true,
        controller: email,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Email',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.mail, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        validator: (value){

          if(value!.isEmpty){
            return 'Please Enter Your Email';
          }
        },
      ),
    );
  }
  AddressTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
      child: TextFormField(
        autofocus: true,
        controller: address,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Address',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Address',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.location_on, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        validator: (value){
          if(value!.isEmpty){
            return 'Please Enter Your Address';
          }
        },
      ),
    );
  }
  PostalCodeTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
      child: TextFormField(
        autofocus: true,
        controller: postal,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Postal Code',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Postal Code',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.code, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(5)
        ],
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please Enter Postal Code';
          } else if (value.length != 5) {
            return 'Postal Code should be exactly 5 digits';
          }
          return null;
        },
      ),
    );
  }
  PhoneNumberTextField(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
      child: TextFormField(
        autofocus: true,
        controller: number,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withAlpha(80),
            hintText: 'Enter Your Phone Number',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Phone Number',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.mobile_friendly, color: Colors.white,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white)
            )
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11)
        ],
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please Enter Your Phone Number';
          } else if (value.length != 11) {
            return 'Phone Number should be exactly 11 digits';
          }
          return null;
        },
      ),
    );
  }

  PayButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16
              ),
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))
          ),
          onPressed: () {},
          child: Text(
            '\$${(widget.price * widget.item).toStringAsFixed(2)}   Pay',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }

  User(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Billing Address",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
          ),
          Text("Name: ${user.text}",style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
          Text("Address: ${address.text}",style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
          Text("Email: ${email.text}",style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
          Text("Postal Code: ${postal.text}",style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
          Text("Phone No: ${number.text}",style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
        ],
      ),
    );
  }

  Tile(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        elevation: 8,
        child: ListTile(
          horizontalTitleGap: 5,
          leading: Image.asset(widget.url,),
          title: Text(widget.name),
          subtitle: Text(widget.catagory),
          trailing: Text('\$${(widget.price*widget.item).toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),),
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }
  Details(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unit Cost',style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
              ),
              ),
              Text('\$${widget.price.toStringAsFixed(2)}',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quantity',style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
              ),
              ),
              Text(widget.item.toString(),style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SubTotal',style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
              ),
              ),
              Text('\$${(widget.price*widget.item).toStringAsFixed(2)}',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee',style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
              ),
              ),
              Text('Free',style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
          Text('-------------------------------------',
            style: TextStyle(
                fontSize: 28,
                color: Colors.grey.shade400
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount',style: TextStyle(
                fontSize: 20,
              ),
              ),
              Text('\$${(widget.price*widget.item).toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Paymethod(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Method",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
          ),
          Text('Google Pay',style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),
          ),
        ],
      ),
    );
  }

  final _key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade500, Colors.purple.shade500])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(
              height: 800,
              child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                        primary: Color(0xffa5e5f0)
                    )
                ),
                child: Stepper(
                    type: StepperType.horizontal,
                    physics: ScrollPhysics(),
                    currentStep: step,
                    onStepContinue: () {
                      if (step == 0 && !_key1.currentState!.validate()) {
                        return;
                      }
                      else{
                        if(step == 2) {
                          FirebaseFirestore.instance.collection('History')
                              .doc(FirebaseAuth.instance.currentUser!.email!)
                              .collection('Records')
                              .doc(widget.name)
                              .set({
                            'name':widget.name,
                            'catagory':widget.catagory,
                            'url':widget.url,
                            'price':widget.price,
                            'items':widget.item,
                            'user':user.text,
                            'email':email.text,
                            'phone':int.parse(number.text),
                            'address':address.text,
                            'total':widget.price * widget.item,
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDone()));
                        }
                        else{
                          setState(() {
                            step+=1;
                          });
                        }
                      }
                    },
                    onStepCancel: () {
                      if(step==0){
                        return ;
                      } else{
                        setState(() {
                          step -=1;
                        });
                      }
                    },
                    steps:[
                      Step(
                          title: Text("Details"),
                          state:step > 0 ? StepState.complete:StepState.indexed,
                          isActive: step>=0,
                          content:Column(
                            children: [
                              Image.asset("assets/logo.png", width: 180, height: 180,),
                              Text("Electronic Store", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                              Text("Shop Smarter not Harder", style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              ),
                              SizedBox(height: 20,),
                              Form(
                                  key: _key1,
                                  child: Column(
                                    children: [
                                      FullNameTextField(),
                                      EmailTextField(),
                                      AddressTextField(),
                                      PostalCodeTextField(),
                                      PhoneNumberTextField()
                                    ],
                                  )
                              )
                            ],
                          )
                      ),
                      Step(
                          title: Text("Payment"),
                          state:step > 1 ? StepState.complete:StepState.indexed,
                          isActive: step>=1,
                          content: Platform.isIOS ? ApplePay : GooglePay
                          // content: PayButton()
                      ),
                      Step(
                          title: Text("Order Details"),
                          isActive: step>=2,
                          content:Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Order Details',style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                User(),
                                SizedBox(height: 20,),
                                Tile(),
                                SizedBox(height: 30,),
                                Details(),
                                SizedBox(height: 30,),
                                Paymethod(),
                              ],
                            ),
                          )
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}