
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  var total=0, productId;

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

                          _quantity(
                              document['count'] ?? 'no product count',
                            document['Product_Id'] ?? 'no product id',
                            document['Product_Category'] ?? 'no product Category',
                            document['Product_Name'] ?? 'no product name',
                            document['Product_Price'] ?? ' no product price',

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


        bottomNavigationBar: _bottomNavBar(),



    );
  }



  Widget _quantity(var countItem, var pId, var pCategory, var pName, var pPrice){

    var count = int.parse(countItem.toString());

    return Container(

      child: Row(
        children: [

          IconButton(
              icon: Icon(CupertinoIcons.minus),
              onPressed: () async {
                if(count <= 0){
                  try {
                    count = 0;
                    //total=0;
                    setState(() {
                      this.total=this.total-0;
                    });
                    FirebaseUser user =
                    await FirebaseAuth.instance.currentUser();
                    final CollectionReference userRef =
                    Firestore.instance.collection('E-Commerce');
                    await userRef
                        .document(user.uid)
                        .collection('product')
                        .document(pId.toString())
                        .updateData({

                      'Product_Id': pId.toString(),
                      'Product_Name': pName.toString(),
                      'Product_Price': pPrice.toString(),
                      'Product_Category': pCategory.toString(),
                      'count': count
                    });
                  } catch (e) {
                    print(e);
                  }
                }else{
                  try{
                    count--;
                    setState(() {
                      this.total=this.total-int.parse(pPrice.toString());
                    });

                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    final CollectionReference userRef = Firestore.instance.collection('E-Commerce');
                    await userRef.document(user.uid).collection('product').document(pId.toString()).updateData({


                      'Product_Id': pId.toString(),
                      'Product_Name': pName.toString(),
                      'Product_Price': pPrice.toString(),
                      'Product_Category': pCategory.toString(),
                      'count': count
                    });
                  }catch(e){
                    print(e);
                  }
                }


              }
          ),
          Text('$count'),

          IconButton(
              icon: Icon(CupertinoIcons.plus),
              onPressed: () async {
                try{
                  count++;
                  setState(() {
                    this.total=this.total+int.parse(pPrice.toString());
                  });

                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  final CollectionReference userRef = Firestore.instance.collection('E-Commerce');
                  await userRef.document(user.uid).collection('product').document(pId.toString()).updateData({


                    'Product_Id': pId.toString(),
                    'Product_Name': pName.toString(),
                    'Product_Price': pPrice.toString(),
                    'Product_Category': pCategory.toString(),
                    'count': count
                  });

                }catch(e){
                  print(e);
                }
              }
          ),



        ],
      ),

    );
  }





  Widget _bottomNavBar(){
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10,bottom: 13),
                child: Column(
                  children: [
                    Text(
                      'TOTAL',
                      style: TextStyle(
                          color: Color(0xFFff9f36),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('\$'+
                        '${this.total}',
                      style: TextStyle(
                          color: Color(0xFFff9f36),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
