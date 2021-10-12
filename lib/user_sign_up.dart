
import 'package:e_commerce/user_sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'user_info.dart';

class User_signUp extends StatefulWidget {
  const User_signUp({Key? key}) : super(key: key);

  @override
  _User_signUpState createState() => _User_signUpState();
}

class _User_signUpState extends State<User_signUp> {

  String _passwrd='',_rpasswrd='';



  final GlobalKey<FormState> _supFormKey = GlobalKey<FormState>();

  Future<void> SignUp () async{
    final supformstate = _supFormKey.currentState;
    if(supformstate!.validate()){
      supformstate.save();
      try{
        if(_passwrd == _rpasswrd && _passwrd.length >= 6){
          FirebaseUser newuser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwrd);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Info(_emailController.text)));
        }
        else if(_passwrd != _rpasswrd){
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Enter same password please."),
            );
          }
          );
        }
        else if (_passwrd.length < 6) {
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Your Password is too Short"),
              content: Text('Please Enter Password More Than 5 Character'),
            );
          }
          );
        }
      }catch(e){
        print(e);
        if(e.toString().substring(0,17)== 'PlatformException'){
          showDialog(context: context, builder: (BuildContext context){
            return new AlertDialog(
              title: new Text('Warning', style: TextStyle(color: Colors.red),),
              content: new Text('User already Exists !'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
        }
        print(e);
        print('>>>>>>>>>>>>>>>-------${e.toString().substring(0,17)}--------<<<<<');
      }
    }
  }

  final TextEditingController _emailController = TextEditingController();

  bool hidepswrd = true;
  void togglePass(){
    setState(() {
      hidepswrd =! hidepswrd;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sign Up',style: TextStyle(color: Colors.black),),
      ),


      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image(image: AssetImage('assets/images/sign_in_up/sign_up.png')),

              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),

                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                  validator: (input){
                    if(input!.isEmpty){
                      return "Please enter an email";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.04,),


              Form(
                key: _supFormKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          obscureText: hidepswrd,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter more than 5 char',
                            suffixIcon: InkWell(
                              onTap: togglePass,
                              child: hidepswrd? Icon(Icons.visibility_off): Icon(Icons.visibility),
                            )
                          ),
                          onSaved: (input){
                            setState(() {
                              _passwrd=input!;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.04,),



                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: TextFormField(
                          obscureText: hidepswrd,
                          decoration: InputDecoration(
                            labelText: 'Re-enter password',
                            hintText: 'Please re-enter password',
                            suffixIcon: InkWell(
                              onTap: togglePass,
                              child: hidepswrd? Icon(Icons.visibility_off): Icon(Icons.visibility),
                            )
                          ),
                          onSaved: (input){
                            setState(() {
                              _rpasswrd=input!;
                            });
                          },
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),

              FlatButton(
                  color: Color(0xFF0fa7d6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  onPressed: (){
                    SignUp();
                  },
                  child: Text('Create Acoount')
              )



            ],
          ),
        ),
      ),
    );
  }
}
