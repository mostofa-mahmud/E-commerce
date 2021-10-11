import 'package:e_commerce/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin_login extends StatefulWidget {
  const Admin_login({Key? key}) : super(key: key);

  @override
  _Admin_loginState createState() => _Admin_loginState();
}

class _Admin_loginState extends State<Admin_login> {
  String _email="",_password="";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> SignIn() async{
    final fromstate = _formkey.currentState;
    if(fromstate!.validate()){
      fromstate.save();
      try{
        if(_email == 'admin@admin.com'){
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Admin_page()));
        }
        else{
          showDialog(context: context, builder: (BuildContext context){
            return new AlertDialog(
              title: new Text('Not an ADMIN !? '),
              content: new Text('Enter valid email/password'),
            );
          });
        }

      }
      catch(e){
        print(e);
      }
    }

  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,


      body: Form(
        key: _formkey,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Admin Sign in",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),

                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image(image: AssetImage('assets/images/sign_in_up/admin.png')),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email"
                      ),
                      onSaved: (input){
                        setState(() {
                          _email=input!;
                        });
                      },
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Please Enter Your Email";
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      onSaved: (input){
                        setState(() {
                          _password=input!;
                        });
                      },
                      validator: (input){
                        if(input!.length<6){
                          return "Password is too small";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      obscureText: _obscureText,

                      decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: InkWell(
                            onTap: _toggle,
                            child: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                          ),
                          labelStyle: TextStyle(color: Colors.black)
                      ),
                    ),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height* 0.03,),

                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          SignIn();
                        });
                      },
                      child: Text("SignIn", style: TextStyle(color: Colors.white),))



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
