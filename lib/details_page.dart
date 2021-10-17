
import 'package:e_commerce/cart.dart';
import 'package:e_commerce/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Details extends StatefulWidget {

  var item, product_name, product_details, price, pic;
  Details(String this.item, String this.product_name, String this.product_details, String this.price, var this.pic);

  @override
  _DetailsState createState() => _DetailsState(this.item, this.product_name, this.product_details, this.price, this.pic);
}

class _DetailsState extends State<Details> {

  var item, product_name, product_details, price, pic,_category;
  _DetailsState(this.item, this.product_name, this.product_details, this.price,this.pic);

  final CollectionReference brewcollection = Firestore.instance.collection('E-Commerce');
  String uid='';

  Future<void> sendDataProduct()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DataBaseProductService(uid: user.uid).UpdateUserData(
        product_name,price,_category = this.item
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFff9f36),
        //automaticallyImplyLeading: false,
        title: Center(child: Text('${this.item}')),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                //child: this.pic,
                child: Image(image: NetworkImage(this.pic),),
              ),
            ),
            Card(
              color: Color(0xFFff9f36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                //side: BorderSide(color: Colors.black),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '${this.product_name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Details: ' '\n${this.product_details}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                            color: Color(0xFFff9f36),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${this.price}',
                        style: TextStyle(
                            color: Color(0xFFff9f36),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 150),
                  child: FlatButton(
                      color: Color(0xFFff9f36),
                      height: 50,
                      minWidth: 120,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      onPressed: () {
                        sendDataProduct();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                      },
                      child: Text('ADD',style: TextStyle(color: Colors.white,fontSize: 20),)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}