import 'package:flutter/material.dart';
import 'keranjangproduk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DetailProduk extends StatefulWidget {
  DetailProduk(this.idproduk, this.emailpenjual,this.harga,this.emailpembeli);
  final String idproduk;
  final String emailpenjual;
  final String harga;
  final String emailpembeli;
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  Future<List> getDetailProduk() async {
    final response = await http.get(
        "http://ethnics.000webhostapp.com/getDetailProduk.php?id_produk=" +
            widget.idproduk +
            "&email_penjual=" +
            widget.emailpenjual);
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  void insertKeranjang() {
    int totalharga =  jumlahorder * int.parse(widget.harga);
    var url = "http://ethnics.000webhostapp.com/insertKeranjang.php?email_pembeli="+widget.emailpembeli+"&jumlah="+jumlahorder.toString()+"&total_harga="+totalharga.toString()+"&id_produk="+widget.idproduk;
    http.get(url);
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new KeranjangPage(widget.emailpembeli)));
  }
  String harga="";
  int jumlahorder = 0;
  
  void tambah() {
    setState(() {
      jumlahorder++;
    });
  }

  void kurang() {
    setState(() {
      if (jumlahorder == 0) {
        jumlahorder = 0;
      } else {
        jumlahorder--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                title: Text("KERANJANG"),
                backgroundColor: Colors.green[700],
              ),
              body: FutureBuilder<List>(
                future: getDetailProduk(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? Container(
                          color: Colors.white,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Container(
                                height: 200.0,
                                child: Image.memory(
                                  base64Decode(snapshot.data[0]["foto_produk"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data[0]["jenis_produk"],
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Rp" + snapshot.data[0]["harga"] + "\n",
                                      style: TextStyle(
                                          color: Colors.green[700],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Deskripsi barang : \n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data[0]["deskripsi"] + "\n",
                                      textAlign: TextAlign.justify,
                                      softWrap: true,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Text(
                                      "Info Penjual : \n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Penjual : " +
                                          snapshot.data[0]["nama"] +
                                          "\nLokasi : " +
                                          snapshot.data[0]["lokasi"] +
                                          "\nAlamat : " +
                                          snapshot.data[0]["alamat"],
                                      textAlign: TextAlign.justify,
                                      softWrap: true,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : new Center(child: new CircularProgressIndicator());
                },
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: FlatButton(
                        shape: Border.all(color: Colors.green[700]),
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green[700]),
                        ),
                        onPressed: () {
                          kurang();
                        },
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: FlatButton(
                        shape: Border.all(color: Colors.green[700]),
                        child: Text(
                          jumlahorder.toString(),
                          style: TextStyle(color: Colors.green[700]),
                        ),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: FlatButton(
                        shape: Border.all(color: Colors.green[700]),
                        child: Text(
                          "+",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green[700]),
                        ),
                        onPressed: () {
                          tambah();
                        },
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                      child: FlatButton(
                        child: Text("Masukan Keranjang"),
                        onPressed: () {                       
                          insertKeranjang();
                        },
                        color: Colors.green[700],
                        textColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
