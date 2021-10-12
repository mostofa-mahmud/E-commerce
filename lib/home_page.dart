
import 'package:e_commerce/admin_login.dart';
import 'package:e_commerce/other_pages.dart';
import 'package:e_commerce/profile.dart';
import 'package:e_commerce/user_history.dart';
import 'package:e_commerce/user_sign_In.dart';
import 'package:flutter/material.dart';

import 'user_info.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  String? _email;
  HomePage(String _email){
    this._email= _email;
  }

  @override
  _HomePageState createState() => _HomePageState(_email!);
}

class _HomePageState extends State<HomePage> {

  String? _email;
  _HomePageState(String _email){
    this._email= _email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFfca903),
        title: Text("Homepage"),
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
                padding: const EdgeInsets.only(left: 20, top: 25),
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
                    Text("Best Selling",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),

              SizedBox( height: MediaQuery.of(context).size.height*0.015,),


              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [

                            Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.30,
                                width: MediaQuery.of(context).size.width*0.65,
                                child: Image(image: AssetImage('assets/images/design/xyz.png')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('Sony earphone',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('XION',style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('\$ 2400',style: TextStyle(color: Colors.white),),
                            )

                          ],
                        ),
                      ],
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [

                            Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                side: BorderSide(color: Colors.black),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.30,
                                width: MediaQuery.of(context).size.width*0.65,
                                child: Image(image: AssetImage('assets/images/design/watch.png')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('MI smartwatch',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('XION',style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 5,),
                              child: Text('\$ 2400',style: TextStyle(color: Colors.white),),
                            )

                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )



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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>User()));
                },
                child: Icon(Icons.perm_identity_outlined))
          ],
        ),
      ),






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
