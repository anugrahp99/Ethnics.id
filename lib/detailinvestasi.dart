import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'bayarinvestasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class Detailinvestasi extends StatefulWidget {
  Detailinvestasi({this.idinvestasi,this.email});
  final String idinvestasi;
  final String email;
  @override
  _DetailinvestasiState createState() => _DetailinvestasiState();
}

class _DetailinvestasiState extends State<Detailinvestasi> {
    Future<List> getDetailInvestasi() async {
    final response =
        await http.get("http://ethnics.000webhostapp.com/getDetailInvestasi.php?id_investasi="+widget.idinvestasi);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
      future: getDetailInvestasi(),
      builder: (context,snapshot){
        if(snapshot.hasError) print(snapshot.error);
        return snapshot.hasData?SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              title: Text("INVESTASI"),
              backgroundColor: Colors.green[700],
            ),
            body: Container(
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Image.memory(
                      base64Decode(snapshot.data[0]["foto_investasi"]),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data[0]["judul"]+"\n",
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        Text(
                          "Presentase keuntungan : "+snapshot.data[0]["profit"]+"%",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Lama Investasi : "+snapshot.data[0]["sisa_hari"]+" hari",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Penanggung Jawab : "+snapshot.data[0]["nama"],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Lokasi Usaha : "+snapshot.data[0]["lokasi"],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Dana Dibutuhkan : Rp"+snapshot.data[0]["dana_dibutuhkan"],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Dana Terkumpul : Rp"+snapshot.data[0]["dana_terkumpul"],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        new LinearPercentIndicator(
                          alignment: MainAxisAlignment.start,
                          animation: true,
                          animationDuration: 2000,
                          lineHeight: 10.0,
                          width: MediaQuery.of(context).size.width * 0.9,
                          percent: (int.parse(snapshot.data[0]["dana_terkumpul"])/int.parse(snapshot.data[0]["dana_dibutuhkan"])),
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.green[700],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: FlatButton(
                        child: Text("Beri Modal"),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new BayarInvestasiPage(idinvestasi: snapshot.data[0]["id_investasi"],email: widget.email,)));
                        },
                        color: Colors.green[700],
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ):new Center(child: new CircularProgressIndicator(),);
      },
    );
  }
}
