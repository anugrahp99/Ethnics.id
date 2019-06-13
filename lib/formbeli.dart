import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'statusproduk.dart';
import 'package:http/http.dart' as http;

class FormBeli extends StatefulWidget {
  FormBeli({this.list});
  final List list;

  @override
  _FormBeliState createState() => _FormBeliState();
}
// list.forEach((element) => print(element));
class _FormBeliState extends State<FormBeli> {
void bayar(){
  widget.list.forEach((element)=>
  {
   http.get("http://ethnics.000webhostapp.com/bayarProduk.php?id_pembelian="+element["id_pembelian"])
  }
  );
  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new StatusProdukPage(widget.list[0]["email_pembeli"])));
}


  TextEditingController nama = new TextEditingController();
  TextEditingController nomor = new TextEditingController();
  TextEditingController kota = new TextEditingController();
  TextEditingController kodepost = new TextEditingController();
  TextEditingController alamat = new TextEditingController();

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
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Silahkan Isi Data Pembeli.\n",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14.0),
                    ),
                    Form(
                      child: TextFormField(
                        controller: nama,
                        autofocus: true,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Nama Penerima",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[700])),
                          isDense: true,
                        ),
                      ),
                    ),
                    Text("\n"),
                    Form(
                      child: TextFormField(
                        controller: nomor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Nomor Handphone",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[700])),
                            isDense: true),
                      ),
                    ),
                    Text("\n"),
                    Form(
                      child: TextFormField(
                        controller: kota,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "Kota atau Kecamatan",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[700])),
                            isDense: true),
                      ),
                    ),
                    Text("\n"),
                    Form(
                      child: TextFormField(

                        controller: kodepost,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Kode Pos",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[700])),
                            isDense: true),
                      ),
                    ),
                    Text("\n"),
                    Form(
                      child: TextFormField(
                        controller: alamat,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Alamat",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[700])),
                            isDense: true),
                      ),
                    ),
                    Text("\n"),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                          child: Container(
                            child: FlatButton(
                              child: Text("Proses"),
                              onPressed: () {
                                bayar();
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
