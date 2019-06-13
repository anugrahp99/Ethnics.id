import 'package:flutter/material.dart';
import 'statusinvestasi.dart';
import 'package:http/http.dart' as http;


class BayarInvestasiPage extends StatelessWidget {
  BayarInvestasiPage({this.email, this.idinvestasi});
  final String idinvestasi;
  final String email;
  final TextEditingController norekController = new TextEditingController();
  final TextEditingController namarekController = new TextEditingController();
  final TextEditingController nominalController = new TextEditingController();


  void bayarInvestasi() {
    var url = "http://ethnics.000webhostapp.com/bayarInvestasi.php";
    http.post(url, body: {
      "no_rekening_pembeli": norekController.text,
      "nama_rekening_pembeli": namarekController.text,
      "email": email,
      "nominal": nominalController.text,
      "id_investasi": idinvestasi
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: Text("PEMBAYARAN INVESTASI"),
          backgroundColor: Colors.green[700],
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
             new Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   new Text(
                      "Silahkan Transfer sejumlah uang yang anda tentukan ke rekening BCA a.n ETHNICS dalam tenggang waktu 5 jam.\n",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14.0),
                    ),
                    new TextField(
                      controller: nominalController,
                      keyboardType: TextInputType.number,
                      onChanged: (value)=>nominalController.text=value,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        )
                      ),
                    ),
                   new  Text(
                      "\nSilahkan isi nama pemiliki dan nomor rekening anda.\n",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14.0),
                    ),
                    new TextField(
                      controller: namarekController,
                      onChanged: (value)=>namarekController.text=value,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Nama Pemilik Rekening",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        )
                      ),
                    ),
                 new   Text("\n"),
                  new  TextField(
                      controller: norekController,
                      onChanged: (value)=>norekController.text=value,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Nomor Rekening",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        )
                      ),
                    ),
                  new  Text("\n"),
                new    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                          child: Container(
                            child: FlatButton(
                              child: Text("Proses"),
                              onPressed: () {
                                bayarInvestasi();
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new StatusInvestasiPage(email)));
                              },
                              color: Colors.green[700],
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
