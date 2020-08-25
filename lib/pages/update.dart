import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/model/productModel.dart';

//import 'package:messageapp/pages/details.dart';
import 'package:uuid/uuid.dart';

class Update extends StatefulWidget {
  final String id;

  const Update({Key key, this.id}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
//  String sellerId = Uuid().v4();
  TextEditingController updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              Firestore.instance
                  .collection("products")
                  .document(widget.id)
                  .collection("userProduct")
                  .document()
                  .setData({
                'product': updateController.text,
                'id': widget.id,
              });
              Future.delayed(Duration(milliseconds: 1), () {
                updateController.clear();
              });
            },
            child: Text('update'),
          ),
        ],
        title: TextFormField(
          controller: updateController,
          decoration: InputDecoration(hintText: 'enter your product name'),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            StreamBuilder(
              stream: Firestore.instance
                  .collection("products")
                  .document(widget.id)
                  .collection("userProduct")
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                            product:
                                snapshot.data.documents[index].data['product'],
                            id: widget.id,
                          );
                        })
                    : Text(
                        "No Products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String id, product;

  const ProductTile({Key key, this.id, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListTile(
        trailing: IconButton(
          onPressed: () {
            Firestore.instance
                .collection("products")
                .document(id)
                .collection("userProduct")
                .document()
                .delete();
          },
          icon: Icon(Icons.delete),
        ),
        title: Text(
          product,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
    ;
  }
}
