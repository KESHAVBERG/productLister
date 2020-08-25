import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  final String product;

  ProductModel({this.product});
  factory ProductModel.formDocument(DocumentSnapshot doc){
    return ProductModel(
      product: doc['product']
    );
  }
}