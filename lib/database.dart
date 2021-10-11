import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUserService{
  String? uid;
  DataBaseUserService({this.uid});

  final CollectionReference user = Firestore.instance.collection('E-Commerce');

  Future UpdateUserData(String _name, _address, _mobile, _email) async{
    return await user.document(uid).setData({
      'First_Name': _name,
      'Address': _address,
      'Mobile': _mobile,
      'E-Mail': _email,
    });
  }
  Future updateuserimage(String image) async{
    return await user.document(uid).updateData({
      'Image': image,
    });
  }
}
