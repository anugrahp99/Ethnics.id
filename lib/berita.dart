import 'package:flutter/material.dart';
import 'detailberita.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  Future<List> getArtikel() async {
    final response = await http.get("http://ethnics.000webhostapp.com/getArtikel.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List>(
          future: getArtikel(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new Artikel(
                    list: snapshot.data,
                  )
                : new Center(child: new CircularProgressIndicator());
          },
        ));
  }
}

class Artikel extends StatelessWidget {
  final List list;
  Artikel({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  new Expanded(
                    child: Container(
                      height: 200.0,
                      child: Image(
                        image: MemoryImage(
                         base64Decode(list[i]["foto_artikel"],
                         
                      ),
                      ),
                      fit: BoxFit.cover,
                      )
                    ),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        list[i]['judul'],
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(list[i]['isi'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 12.0)),
                      Text(
                        list[i]['tanggal'].toString(),
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return GestureDetector(
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              new Expanded(
                flex: 2,
                child: Container(
                  height: 120.0,
                  child:Image(
                        image: MemoryImage(
                         base64Decode(list[i]["foto_artikel"],
                      ),
                      ),
                      fit: BoxFit.cover,
                      ),
                ),
              ),
              new Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0,bottom: 3.0),
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        list[i]['judul'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                       Text(list[i]['isi'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 12.0)),
                      Text(
                        list[i]['tanggal'].toString(),
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              )
            ]),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailBeritaPage(list[i]['id_artikel'])));
            },
          );
        }
      },
    );
  }
}

// ListView(
//         scrollDirection: Axis.vertical,
//         children: <Widget>[

//         ],
//       ),
