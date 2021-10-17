
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/details_page.dart';
import 'package:e_commerce/home_page.dart';
import 'package:e_commerce/profile.dart';
import 'package:e_commerce/user_history.dart';
import 'package:e_commerce/user_sign_In.dart';
import 'package:flutter/material.dart';

class Other_pages extends StatefulWidget {
  //const Other_pages({Key? key}) : super(key: key);

  String? page;
  String? _email;
  Other_pages(String _email, String page){
    this._email= _email;
    this.page = page;
  }


  @override
  _Other_pagesState createState() => _Other_pagesState(this._email!, this.page!);
}

class _Other_pagesState extends State<Other_pages> {

  String? page;
  String? _email;
  _Other_pagesState(String _email, String page){
    this.page = page;
    this._email= _email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Color(0xFFfca903),
        title: Text("Other Pages"),
      ),



      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFfca903),


        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Text("Categories",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),


              SizedBox( height: MediaQuery.of(context).size.height*0.02,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,


                child: Row(
                  children: [



                    _buildctgry('assets/images/design/woman.png', "Women"),



                    _buildctgry('assets/images/design/men.png', "Men"),


                    _buildctgry('assets/images/design/devices.png', "Devices"),


                    _buildctgry('assets/images/design/games.png', "Software"),


                    _buildctgry('assets/images/design/Gadgets.png', "Gadgets"),


                    _buildctgry('assets/images/design/baby.png', "Baby"),




                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Row(


                  children: [
                    Text("Products",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),


                    SizedBox(width: MediaQuery.of(context).size.width * 0.45),


                    FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(_email.toString())));
                          },
                        child: Text('Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                    ),


                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height* 0.02,),

              if(page == 'Gadgets')...[
                _showProductItems('Gadgets')
              ]else if(page == 'Women')...[
                _showProductItems('Women')
              ]





            ],
          ),
        ),


      ),


      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height*0.08,
        child: Row(
          children: [
            FlatButton(
                onPressed: (){

                },
                child: Icon(Icons.home)),
            SizedBox(width: 60,),
            FlatButton(
                onPressed: (){

                },
                child: Icon(Icons.add_shopping_cart)),

            SizedBox(width: 60,),
            FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>User(_email!)));
                },
                child: Icon(Icons.perm_identity_outlined))
          ],
        ),
      ),



    );
  }







  Widget _showProductItems(String caregoryName){
    String item =caregoryName ;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(caregoryName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text("Loading"),
          );
        }else{
          return ListView(

            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data!.documents.map((document){
              return FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(
                        item,
                        document['_product_name'] ?? '',
                        document['_product_details'] ?? '',
                        document['_product_price'] ?? '',
                        document['Image']??''
                    )));
                  },
                  child: ListTile(

                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 15,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15)
                            ),
                            side: BorderSide(color: Colors.black)
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height* 0.3,
                            width: MediaQuery.of(context).size.width* 0.5,
                            child: Image(
                                image: NetworkImage(document['Image'] ?? ''
                                )
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document['_product_name'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              document['_product_details'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              document['_product_price'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.015,)
                          ],
                        ),




                      ],
                    ),
                  )
              );
            }).toList());
        }
        },
    );
  }



  Widget _buildctgry(String assetImg, String assTxt){
    return Row(

      children: [
        SizedBox(width: 20,),
        Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(5),
                  primary: Color(0xffb38300),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Other_pages(_email.toString(),assTxt)));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Image(
                      image: AssetImage(assetImg),
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill
                  ),
                )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.01,
            ),
            Text(assTxt, style: TextStyle(color: Colors.white, fontSize: 16),),
          ],
        ),

      ],
    );
  }
}
