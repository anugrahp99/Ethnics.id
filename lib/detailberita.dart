import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DetailBeritaPage extends StatefulWidget {
  DetailBeritaPage(this._idartikel);
  final String _idartikel;
  @override
  _DetailBeritaPageState createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  Future<List> getDetailArtikel() async {
    final response = await http.get(
        "http://ethnics.000webhostapp.com/getDetailBerita.php?id_artikel=" +
            widget._idartikel);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
      future: getDetailArtikel(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? SafeArea(
                child: Stack(
                  children: <Widget>[
                    new Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: new AppBar(
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "ET",
                              style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "HNICS." + "BERITA",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ),
                      body: Container(
                        color: Colors.white,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                   snapshot.data[0]["judul"],
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  Text(
                                    snapshot.data[0]["tanggal"],
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200.0,
                              child: Image(
                        image: MemoryImage(
                         base64Decode(snapshot.data[0]["foto_artikel"],
                         
                      ),
                      ),
                      fit: BoxFit.cover,
                      )
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data[0]["isi"],
                                   textAlign: TextAlign.justify,
                                    softWrap: true,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}
