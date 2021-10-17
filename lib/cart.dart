

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  FirebaseUser? user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe37c22),
      appBar: AppBar(
        backgroundColor: Color(0xFFe37c22),
        title: Text('Cart'),
      ),



      body: StreamBuilder(
        stream: Firestore.instance.collection('E-Commerce').document(user!.uid).collection('product').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
            if (!snapshot.hasData) {
              return Text('Loding..');
            } else
              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.documents.map((document){
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,

                    child: ListTile(
                      title: Row(
                        children: [


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,


                            children: [
                              Text(
                                document['Product_Name'] ?? 'No product available',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                document['Product_Price'] ?? "No Product Available",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),


                          SizedBox(width: MediaQuery.of(context).size.width * 0.25,),


                          FlatButton(
                              onPressed: (){

                                showDialog(context: context, builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: new Text("Are You sure Want to Delete"),
                                    content: Row(

                                      children: [
                                        FlatButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              },
                                            child: Text('Cancel')
                                        ),
                                        FlatButton(
                                            onPressed: (){
                                              String productid = document.documentID;
                                              DocumentReference documentreference = Firestore.instance.collection('E-Commerce').document(user!.uid).collection('product').document(productid);
                                              documentreference.delete().then((value) => Navigator.pop(context));
                                              },
                                            child: Text('Delete')
                                        )
                                      ],

                                    ),
                                  );
                                }
                                );

                              },
                              child: Icon(Icons.delete, color: Colors.white,)
                          )


                        ],
                      ),
                    ),


                  );
                }).toList(),

              );
          }),
    );
  }
}
