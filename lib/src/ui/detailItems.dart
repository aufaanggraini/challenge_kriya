import 'package:coding_challenge_from_kriya/src/db/dbProvider.dart';
import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';
import 'package:coding_challenge_from_kriya/src/ui/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailItems extends StatefulWidget {
  final int totalItems;
  final List<Sample> listProduct;
  DetailItems({this.totalItems, this.listProduct, Key key}) : super(key: key);

  @override
  _DetailItemsState createState() => _DetailItemsState();
}

class _DetailItemsState extends State<DetailItems> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Total Items = ${widget.totalItems}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: widget.listProduct.length,
                  itemBuilder: (contex, index) {
                    return ListTile(
                      title: Text(widget.listProduct[index].title),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 60.0,
                color: Colors.blue,
                width: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              listProduct: widget.listProduct,
                            )));
              },
              child: Container(
                height: 60.0,
                color: Colors.blue,
                width: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: Text(
                    "Beli",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
