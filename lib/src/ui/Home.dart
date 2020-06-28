import 'package:coding_challenge_from_kriya/src/blocs/sampleBloc.dart';
import 'package:coding_challenge_from_kriya/src/db/dbProvider.dart';
import 'package:coding_challenge_from_kriya/src/db/itemCount.dart';
import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';
import 'package:coding_challenge_from_kriya/src/ui/detailItems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  List<Sample> listProduct;
  Home({this.listProduct, Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isBottonDisable;
  int totalItems = 0;
  List<Sample> product = new List();

  void cekProduct() {
    widget.listProduct = product;
  }

  @override
  void initState() {
    bloc.fetchAllSample();
    cekProduct();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Tes Kriya'),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('${totalItems.toString()}'),
          )),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allSample,
        builder: (context, AsyncSnapshot<List<Sample>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        child: Builder(builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              if (totalItems == 0) {
                isBottonDisable = true;
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Tambahkan Item Terlebih Dahulu")));
              } else {
                print("test" + product.length.toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            DetailItems(
                              totalItems: totalItems,
                              listProduct: product,
                            )));
              }
              setState(() {});
            },
            child: Container(
              color: Colors.blue,
              height: 50.0,
              child: Center(
                child: Text(
                  "Checkout",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Sample>> snapshot) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data[index].title),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  int total = 0;
                                  if (snapshot.data[index].qty == 0) {
                                    isBottonDisable = true;
                                  } else {
                                    snapshot.data[index].qty--;
                                    snapshot.data
                                        .forEach((e) => total += e.qty);
                                    product.removeAt(index);
                                    totalItems = total;
                                  }
                                });
                              },
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.do_not_disturb_on),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(snapshot.data[index].qty.toString()),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                int total = 0;
                                snapshot.data[index].qty++;
                                snapshot.data.forEach((e) => total += e.qty);
                                totalItems = total;
                                if (snapshot.data[index].qty >= 1) {
                                  product.add(Sample(
                                      id: snapshot.data[index].id,
                                      qty: snapshot.data[index].qty,
                                      title: snapshot.data[index].title));
                                  print(product[index].title);
                                  print(product.length);
                                } else if (snapshot.data[index].qty == 0) {
                                  product.removeAt(index);
                                  print(product[index].title);
                                  print(product.length);
                                }

                                setState(() {});
                              },
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.add_circle),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
