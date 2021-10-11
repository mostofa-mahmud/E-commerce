import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_page extends StatefulWidget {
  const Admin_page({Key? key}) : super(key: key);

  @override
  _Admin_pageState createState() => _Admin_pageState();
}

class _Admin_pageState extends State<Admin_page> {

  var _product;
  String _product_name="", _product_price="", _product_details="", image="", _category="";
  List productItem= [
    "Women",
    "Men",
    "Devices",
    "Gadgets",
    "Games",
  ];


  File? _image;

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

  Future<void> sendData() async{
    var storageImage= FirebaseStorage.instance.ref().child(_image!.path);
    var task = storageImage.putFile(_image);
    String imgUrl = await (await task.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await(imgUrl);
    Firestore.instance.collection(_category).add({
      '_product_name': _product_name,
      '_product_price': _product_price,
      '_product_details': _product_details,
      'Image': imgUrl,
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe37c22),

      appBar: AppBar(
        backgroundColor: Color(0xFFe37c22),
        automaticallyImplyLeading: false,

        title: Text("Admin Panel"),
        actions: [
          FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.orangeAccent,
              onPressed: (){

              },
              child: Text("User History")
          )
        ],

      ),



      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(


              child: DropdownButton(
                iconEnabledColor: Colors.white,
                dropdownColor: Color(0xFFe37c22),
                hint: Text(
                  "Select a Category",
                  style: TextStyle(color: Colors.white),
                ),
                value: _product,
                onChanged: (newValue){
                  setState(() {
                    _product= newValue;
                  });
                },
                items: productItem.map((valueitem) {
                  if (_product == 'Women') {
                    _category = 'Women';
                  } else if (_product == 'Men') {
                    _category = 'Men';
                  } else if (_product == 'Devices') {
                    _category = 'Devices';
                  } else if (_product == 'Gadgets') {
                    _category = 'Gadgets';
                  } else if (_product == 'Games') {
                    _category = 'Games';
                  }
                  print(_category);
                  return DropdownMenuItem(
                      value: valueitem,
                      child: Text(
                        valueitem,
                        style: TextStyle(color: Colors.white),
                      ));
                }).toList(),



              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),


            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
              height: MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width*0.19,
              child: _image == null ? Text("") : Image.file(_image!),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    cameraImage();
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFFe37c22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    gallaryImg();
                  },
                  child: Icon(Icons.photo_library_outlined,
                      color: Color(0xFFe37c22)),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (input) {
                  setState(() {
                    _product_name = input;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Product Price",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (input) {
                  setState(() {
                    _product_price = input;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Product Details",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (input) {
                  setState(() {
                    _product_details = input;
                  });
                },
              ),
            ),


            Padding(
                padding: EdgeInsets.only(top: 15),
              child: FlatButton(
                color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  onPressed: (){
                  sendData();
                  },
                  child: Text("Save")),
            )
          ],
        ),
      ),


    );
  }

}
