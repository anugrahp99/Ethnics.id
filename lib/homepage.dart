import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'detailinvestasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage(this.email);
  final String email;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getInvestasi() async {
    final response =
        await http.get("http://ethnics.000webhostapp.com/getInvestasi.php");
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
          Text(
            "Populer",
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: 210.0,
            width: 200.0,
            color: Colors.transparent,
            child: FutureBuilder<List>(
          future: getInvestasi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new Investasi(
                    list: snapshot.data,
                  )
                : new Center(child: new CircularProgressIndicator());
          },
        )
          ),
          Text(
            "Terdekat",
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: 210.0,
            width: 200.0,
            color: Colors.transparent,
            child: FutureBuilder<List>(
          future: getInvestasi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new Investasi(
                    list: snapshot.data,
                  )
                : new Center(child: new CircularProgressIndicator());
          },
        )
          ),
        ],
      ),
    );
  }
}

class Investasi extends StatelessWidget {
  Investasi({this.list});
 final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
       itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
      return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Detailinvestasi(idinvestasi: list[i]["id_investasi"],)));
      },
      child: Card(
        elevation: 2.0,
        child: Container(
          width: 150.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: Container(
                  height: 100.0,
                  child: Image.memory(
                    base64Decode( list[i]["foto_investasi"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Column(
                  children: <Widget>[
                    Text(
                      list[i]["judul"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    new LinearPercentIndicator(
                      width: 140.0,
                      lineHeight: 10.0,
                      percent:(int.parse(list[i]["dana_terkumpul"])/int.parse(list[i]["dana_dibutuhkan"])),
                      backgroundColor: Colors.grey[300],
                      progressColor: Colors.green[700],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Terkumpul",
                          style:
                              TextStyle(fontSize: 9.0, color: Colors.grey[400]),
                        ),
                        Text(
                          "Sisa hari",
                          style:
                              TextStyle(fontSize: 9.0, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          list[i]["dana_terkumpul"],
                          style:
                              TextStyle(fontSize: 9.0, color: Colors.black87),
                        ),
                        Text(
                          list[i]["sisa_hari"],
                          style:
                              TextStyle(fontSize: 9.0, color: Colors.black87),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
      }
    );
  }
}
