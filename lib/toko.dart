import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'detailproduk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TokoPage extends StatefulWidget {
  TokoPage(this.emailpembeli);
  final String emailpembeli;
  @override
  _TokoPageState createState() => _TokoPageState();
}

class _TokoPageState extends State<TokoPage> {
  Future<List> getProduk() async {
    final response =
        await http.get("http://ethnics.000webhostapp.com/getProduk.php");
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                  hintText: "Apa yang sedang anda cari ?",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          FutureBuilder<List>(
            future: getProduk(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ListProduk(
                      list: snapshot.data,emailpembeli: widget.emailpembeli,
                    )
                  : new Center(child: new CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  ListProduk({this.list,this.emailpembeli});
  final List list;
  final String emailpembeli;
  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
        itemCount: list == null ? 0 : list.length,
        shrinkWrap: true,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.35)),
        itemBuilder: (BuildContext context, int i) {
          return new GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 5.0, bottom: 10.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Image.memory(
                      base64Decode(list[i]["foto_produk"]),
                      fit: BoxFit.cover,
                      height: 120.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          list[i]["jenis_produk"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Rp" + list[i]["harga"] + ",-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        Text(
                          list[i]["lokasi"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 10.0),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          width: 160,
                          height: 20.0,
                          child: FlatButton(
                            child: Text("Beli"),
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailProduk(list[i]["id_produk"],list[i]["email_penjual"],list[i]["harga"],emailpembeli)));
                            },
                            color: Colors.green[700],
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailProduk(list[i]["id_produk"],list[i]["email_penjual"],list[i]["harga"],emailpembeli)));
            },
          );
        });
  }
}
//  ListView(
//         padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//         children: <Widget>[

//         ],
//       ),

// return new Row(
//   mainAxisSize: MainAxisSize.max,
//   children: <Widget>[
//     new Expanded(
//       child: GestureDetector(
//         child: Container(
//           margin: EdgeInsets.only(right: 5.0, bottom: 10.0),
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                 child: Image.asset(
//                   widget.gambar,
//                   fit: BoxFit.cover,
//                   height: 120.0,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       widget.judul,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       widget.harga + ",-",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 12.0),
//                     ),
//                     Text(
//                       widget.asal,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w200, fontSize: 10.0),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       width: 160,
//                       height: 20.0,
//                       child: FlatButton(
//                         child: Text("Beli"),
//                         onPressed: () {},
//                         color: Colors.green[700],
//                         textColor: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),

//       ),
//     ),
//     new Expanded(
//       child: GestureDetector(
//         child: Container(
//           margin: EdgeInsets.only(right: 5.0, bottom: 10.0),
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                 child: Image.asset(
//                   widget.gambar,
//                   fit: BoxFit.fitHeight,
//                   height: 120.0,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       widget.judul,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       widget.harga + ",-",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 12.0),
//                     ),
//                     Text(
//                       widget.asal,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w200, fontSize: 10.0),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       width: 160,
//                       height: 20.0,
//                       child: FlatButton(
//                         child: Text("Beli"),
//                         onPressed: () {},
//                         color: Colors.green[700],
//                         textColor: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         onTap: () {
//           Navigator.of(context).push(new MaterialPageRoute(
//               builder: (BuildContext context) => new DetailProduk()));
//         },
//       ),
//     ),
//   ],
// );

///
///
//  GestureDetector(
//           child: Container(
//               margin: EdgeInsets.only(right: 5.0, bottom: 10.0),
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Image.memory(
//                       base64Decode(list[i]["foto_produk"]),
//                       fit: BoxFit.cover,
//                       height: 120.0,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//           Text(
//             list[i]["jenis_produk"],
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//           Text(
//             "Rp"+list[i]["harga"] + ",-",
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 12.0),
//           ),
//           Text(
//             list[i++]["lokasi"],
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 fontWeight: FontWeight.w200, fontSize: 10.0),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
//             width: 160,
//             height: 20.0,
//             child: FlatButton(
//               child: Text("Beli"),
//               onPressed: () {},
//               color: Colors.green[700],
//               textColor: Colors.white,
//             ),
//           )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           onTap: () {
//             Navigator.of(context).push(new MaterialPageRoute(
//                 builder: (BuildContext context) => new DetailProduk()));
//           },
//         );


