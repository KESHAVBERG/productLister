import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/pages/update.dart';

class Search extends StatefulWidget {
  final String id;

  const Search({Key key, this.id}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchcontroller = TextEditingController();
  QuerySnapshot searchSnapshot, productSnapshot;

  showResult() {
    return searchSnapshot != null
        ? Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchSnapshot.documents.length,
                itemBuilder: (context, index) {
                  return searchTitle(
                      sn: searchSnapshot.documents[index].data['shopName'],
                      add: searchSnapshot.documents[index].data['add'],
                      img: searchSnapshot.documents[index].data['image'],
                      id: searchSnapshot.documents[index].data['id']);
                }),
          )
        : Container(
      padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("nothing Found",style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),));
  }

  Widget searchTitle({String sn, add, img, id}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(img),
      ),
      title: Text(sn),
      subtitle: Text(add),
      trailing: FlatButton(
        onPressed: () {
//          Firestore.instance
//          .collection("products")
//          .document(widget.id)
//          .collection("userProduct")
//          .get().then((value) {
//            setState(() {
//              productSnapshot = value;
//            });
//          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Update(
                        id: id,
                      )));
        },
        child: Text("view products"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    hintText: "search by shop name",
                    suffixIcon: IconButton(
                      onPressed: () {
                        Firestore.instance
                            .collection("user")
                            .where("shopName",
                                isGreaterThanOrEqualTo: searchcontroller.text)
                            .getDocuments()
                            .then((value) {
                          setState(() {
                            searchSnapshot = value;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ),
            ),
            showResult()
          ],
        ),
      ),
    );
  }
}
