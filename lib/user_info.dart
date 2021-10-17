import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/database.dart';
import 'package:e_commerce/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class User_Info extends StatefulWidget {
  //const User_Info({Key? key}) : super(key: key);
  String? _email;
  User_Info(String _email){
    this._email= _email;
  }

  @override
  _User_InfoState createState() => _User_InfoState(_email!);
}

class _User_InfoState extends State<User_Info> {
  String? _email;
  _User_InfoState(String _email){
    this._email= _email;
  }

  final CollectionReference brewcollection = Firestore.instance.collection('E-Commerce');
  
  Future<void> sendData() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DataBaseUserService(uid: user.uid).UpdateUserData(_name, _address, _mobile, this._email);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> User(_email!)));
  }

  sendImage() async {
    var storageImage = FirebaseStorage.instance.ref().child(_image!.path);
    var task = storageImage.putFile(_image);
    String imgurl = await (await task.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DataBaseUserService(uid: user.uid).updateuserimage(imgurl);
  }



  File? _image;

  String _name='',_address='',_mobile='';

  Future cameraImage() async{
    final pickedFile= await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile!= null){
        _image = File(pickedFile.path);
      }else{
        print('no image selected');
      }
    });
  }

  Future gallaryImg() async{
    final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color(0xFFff9f36),
      appBar: AppBar(
        backgroundColor: Color(0xFFff9f36),
        title: Text('User Info'),
      ),


      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('User Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5)
                ),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: _image == null? Text(""):Image.file(_image!),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      onPressed: (){
                        cameraImage();
                      },
                    child: Icon(Icons.camera_alt_outlined),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width *0.05, ),
                  FloatingActionButton(
                    onPressed: (){
                      gallaryImg();
                    },
                    child: Icon(Icons.photo_library_outlined),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Your Full Name"),
                  onChanged: (input){
                    setState(() {
                      _name=input;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Your Current Location"),
                  onChanged: (input){
                    setState(() {
                      _address=input;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                  InputDecoration(
                      labelText: "Mobile No",
                      hintText: "01xxxxxxxxx"
                  ),
                  onChanged: (input){
                    setState(() {
                      _mobile=input;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),



              FlatButton(
                  color: Color(0xFFff503d),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  onPressed: () {
                    sendData();
                    sendImage();
                  },
                  child: Text("Save Information",style: (TextStyle(color: Colors.white,fontSize: 18)),)
              )




            ],
          ),
        ),
      ),
    );
  }
}
