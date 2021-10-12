import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User_history extends StatefulWidget {
  const User_history({Key? key}) : super(key: key);

  @override
  _User_historyState createState() => _User_historyState();
}

class _User_historyState extends State<User_history> {



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color(0xFFe37c22),
      appBar: AppBar(
        backgroundColor: Color(0xFFe37c22),
        title: Text('User History'),
      ),


      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('E-Commerce').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return Text('Loding...');
            }else{
              return ListView(

                shrinkWrap: true,
                children: snapshot.data!.documents.map((document){
                  return Container(

                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,

                    child: ListTile(

                        title: Text(
                          document['First_Name'] ?? '',
                          style: TextStyle(color: Colors.white),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(document['Address'] ?? '', style: TextStyle(color: Colors.white),),
                            Text(document['E-Mail'] ?? '', style: TextStyle(color: Colors.white),),
                            Text(document['Mobile'] ?? '', style: TextStyle(color: Colors.white),),

                            FlatButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .circular(20)
                                ),
                                onPressed: () {
                                  String userid = document.documentID;
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Order_History(userid)));
                                  },
                                child: Text('Order History')
                            )


                          ],
                        )
                    ),

                  );
                }).toList());
            }
        },
      ),

    );
  }
}
