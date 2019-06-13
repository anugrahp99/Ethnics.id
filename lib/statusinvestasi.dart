import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class StatusInvestasiPage extends StatelessWidget {
    StatusInvestasiPage(this.email);
  final String email;

 Future<List> getStatusInvestasi() async {
    final response =
        await http.get("http://ethnics.000webhostapp.com/getStatusInvestasi.php?email="+email);
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
            title: Text("STATUS PESANAN"),
            backgroundColor: Colors.green[700],
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            child: FutureBuilder<List>(
          future: getStatusInvestasi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ListInvestasi(
                    list: snapshot.data,
                  )
                : new Center(child: new CircularProgressIndicator());
          },
        )
          )),
    );
  }
  }



class ListInvestasi extends StatelessWidget {
  ListInvestasi({this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
       return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
    return GestureDetector(
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        new Expanded(
          flex: 2,
          child: Container(
            height: 120.0,
            child: Image.memory(
              base64Decode(list[i]["foto_investasi"]),
              alignment: FractionalOffset.center,
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Expanded(
          flex: 4,
          child: Container(
            margin: EdgeInsets.only(left: 10.0),
            height: 120.0,
            child: ListView(
                          children: <Widget>[
                            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                            list[i]["judul"]+"\n",
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          Text(
                            "Presentase keuntungan : "+list[i]["profit"]+"%",
                            style: TextStyle(fontWeight: FontWeight.w500
                            ,fontSize: 12.0
                            ),
                          ),
                          Text(
                            "Lama Investasi : "+list[i]["sisa_hari"]+"hari",
                            style: TextStyle(fontWeight: FontWeight.w500
                            ,fontSize: 12.0),
                          ),
                          Text(
                            "Penanggung Jawab : "+list[i]["nama"],
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12.0),
                          ),
                          Text(
                            "Lokasi Usaha : "+list[i]["lokasi"],
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12.0),
                          ),
                ],
              ),
                          ] 
            ),
          ),
        ),
      ]),
      onTap: () {},
    );
      },
    );
  }
}
    //        return GestureDetector(
    //   child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //     new Expanded(
    //       flex: 2,
    //       child: Container(
    //         height: 100.0,
    //         child: Image.memory(
    //           base64Decode(list[i]["foto_investasi"]),
    //           alignment: FractionalOffset.center,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //     new Expanded(
    //       flex: 4,
    //       child: Container(
    //         margin: EdgeInsets.only(left: 10.0),
    //         height: 100.0,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               list[i]["judul"],
    //               maxLines: 2,
    //               overflow: TextOverflow.visible,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 16.0,
    //               ),
    //             ),
    //             Text(
    //               "\nJumlah Barang :  " +
    //                   waktu.toString() +
    //                   "\nHarga                 :  " +
    //                   waktu.toString()+"\nStatus Pembayaran : Sukses ",
    //               textAlign: TextAlign.left,
    //               style: TextStyle(color: Colors.grey[900], fontSize: 13.0),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ]),
    //   onTap: () {},
    // );