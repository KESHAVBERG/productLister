import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel{
  final String email,id,image,name,sn,add;

  ProfileModel({this.email, this.id, this.image, this.name,this.sn,this.add});

  factory ProfileModel.fromDocument(DocumentSnapshot doc){
    return ProfileModel(
      email: doc['email'],
      id: doc['id'],
      image: doc['image'],
      name: doc['name'],
      sn: doc['shopName'],
      add: doc['add']


    );
  }
}