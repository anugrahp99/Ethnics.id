import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class StatusProdukPage extends StatefulWidget {
  StatusProdukPage(this.emailpembeli);
final String emailpembeli;
  @override
  _StatusProdukPageState createState() => _StatusProdukPageState();
}

class _StatusProdukPageState extends State<StatusProdukPage> {
 Future<List> getOrderan() async {
    final response = await http.get(
        "http://ethnics.000webhostapp.com/getOrderan.php?email_pembeli=" +
            widget.emailpembeli);
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.green[700],
          appBar: new AppBar(
            centerTitle: true,
            title: Text("KERANJANG"),
            backgroundColor: Colors.green[700],
            elevation: 0.0,
          ),
          body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  children:[
FutureBuilder<List>(
            future: getOrderan(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ListKeranjang(
                      list: snapshot.data,
                    )
                  : new Center(child: new CircularProgressIndicator());
            },
          ),
         

                  ] 
        ))),
    );
}
}
class ListKeranjang extends StatelessWidget {
  ListKeranjang({this.list});
  final List list;
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
         return Column(
            mainAxisSize: MainAxisSize.min,
                      children:[
                        GestureDetector(
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: Container(
                    height: 100.0,
                    child: Image.memory(
                      base64Decode(list[i]["foto_produk"]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                new Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    height: 100.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          list[i]["jenis_produk"],
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "\nJumlah Barang :  " +
                              list[i]["jumlah"] +
                              "\nHarga                 :  " +
                              list[i]["total_harga"],
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 13.0),
                        )
                      ],
                    ),
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: Container(
                      height: 100.0,
                      ),
                ),
              ]),
              onTap: () {},
            ),
       Divider(
                          height: 1.0,
                        ),
                      ] 
          );
      },
    );
  } 
}
