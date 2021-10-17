import 'package:e_commerce/admin_login.dart';
import 'package:e_commerce/home_page.dart';
import 'package:e_commerce/user_info.dart';
import 'package:e_commerce/user_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User_signIn extends StatefulWidget {
  const User_signIn({Key? key}) : super(key: key);

  @override
  _User_signInState createState() => _User_signInState();
}

class _User_signInState extends State<User_signIn> {

  String _email="",_pass="";

  final GlobalKey<FormState> _sinformKey = GlobalKey<FormState>();

  Future<void> SignIn() async{
    final sinformstate = _sinformKey.currentState;
    if(sinformstate!.validate()){
      sinformstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _pass);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(_email)));
      }catch(e){

        if(e.toString().substring(0,17) == 'PlatformException'){
          showDialog(
              context: context,
              builder: (BuildContext context) => new AlertDialog(
                title: new Text('Warning', style: TextStyle(color: Colors.red),),
                content: new Text('Please Enter valid Email or Password .'),
                actions: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ));

        }
        print(e);
        print('>>>>>>>>>>>>>>>-------${e.toString().substring(0,17)}--------<<<<<');
      }
    }
  }


  bool _obscureText =true;
  void toggle(){
    setState(() {
      _obscureText= !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Get Started",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_login()));
              },
              child: Text("Admin")
          ),

        ],
      ),




      body: Form(
        key: _sinformKey,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Sign in"),
                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                    Container(
                      height: MediaQuery.of(context).size.height* 0.2,
                      child: Image(image: AssetImage('assets/images/sign_in_up/sign_in1.png')),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                    Padding(
                      padding: EdgeInsets.only(left: 30 , right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email'
                        ),
                        onSaved: (input){
                          setState(() {
                            _email=input!;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),

                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _obscureText,


                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                            onTap: toggle,
                            child: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                          )
                        ),

                        onSaved: (input){
                          _pass = input!;
                        },

                      ),
                    ),


                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),


                    FlatButton(
                        color: Color(0xFFb7bdb9),
                        minWidth: MediaQuery.of(context).size.width * 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          setState(() {

                            SignIn();

                            if(_email.isEmpty){
                              showDialog(context: context, builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Please Enter an Email"),
                                );});
                            }
                            else if(_pass.isEmpty){
                              showDialog(context: context, builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Please Enter an Password"),
                                );});
                            }
                          }
                          );
                        },
                        child: Text("Sign In")
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),

                    Text("Don't have an account?"),

                    SizedBox(height: MediaQuery.of(context).size.height* 0.03,),

                    FlatButton(

                        color: Color(0xFFb7bdb9),
                        minWidth: MediaQuery.of(context).size.width * 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> User_signUp()));
                        },
                        child: Text("SignUp", style: TextStyle(color: Colors.black),)
                    )





                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
