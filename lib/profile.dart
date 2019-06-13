import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  ProfilePage(this.email,this.password);
  final String email;
  final String password;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  Future<List> getProfile() async {
    final response =
        await http.post("http://ethnics.000webhostapp.com/getProfile.php", body: {
      "email": widget.email,
      "password": widget.password,
    });
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
      future: getProfile(),
      builder: (context,snapshot){
        if(snapshot.hasError) print(snapshot.error);
        return snapshot.hasData?new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 170.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Gambar(snapshot.data[0]["foto_pembeli"]),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Informasi Pribadi',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? new Container() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    "Nama Lengkap",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: snapshot.data[0]["nama"],
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Tanggal lahir',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                      hintText: snapshot.data[0]["tanggal_lahir"]),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                      hintText: snapshot.data[0]["email_pembeli"]),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                  
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                    ),
                                      hintText: snapshot.data[0]["password"]),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Nomor Handphone',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  decoration: InputDecoration(
                                      hintText: snapshot.data[0]["nomor_handphone"]),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ):new Center(child: new CircularProgressIndicator(),);
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }


  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

class Gambar extends StatelessWidget {
  Gambar(this.image);
  final String image;
  
  @override
  Widget build(BuildContext context) {
    if(image!=""){
      return new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new MemoryImage(
                                        base64Decode(image)
                                        ),
                                    fit: BoxFit.cover,
                                  ),
                                ));
    }
    else{
      return new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image:AssetImage(
                                       "assets/images/user.png"
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ));
    }
    }
  }

  // Padding(
  //                         padding: EdgeInsets.only(
  //                             left: 25.0, right: 25.0, top: 25.0),
  //                         child: new Row(
  //                           mainAxisSize: MainAxisSize.max,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: <Widget>[
  //                             Expanded(
  //                               child: Container(
  //                                 child: new Text(
  //                                   'kode pos',
  //                                   style: TextStyle(
  //                                       fontSize: 16.0,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                               ),
  //                               flex: 2,
  //                             ),
  //                             Expanded(
  //                               child: Container(
  //                                 child: new Text(
  //                                   'Negara',
  //                                   style: TextStyle(
  //                                       fontSize: 16.0,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                               ),
  //                               flex: 2,
  //                             ),
  //                           ],
  //                         )),
  //                     Padding(
  //                         padding: EdgeInsets.only(
  //                             left: 25.0, right: 25.0, top: 2.0),
  //                         child: new Row(
  //                           mainAxisSize: MainAxisSize.max,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: <Widget>[
  //                             Flexible(
  //                               child: Padding(
  //                                 padding: EdgeInsets.only(right: 10.0),
  //                                 child: new TextField(
  //                                   decoration: const InputDecoration(
  //                                       hintText: "Enter Pin Code"),
  //                                   enabled: !_status,
  //                                 ),
  //                               ),
  //                               flex: 2,
  //                             ),
  //                             Flexible(
  //                               child: new TextField(
  //                                 decoration: const InputDecoration(
  //                                     hintText: "Enter State"),
  //                                 enabled: !_status,
  //                               ),
  //                               flex: 2,
  //                             ),
  //                           ],
  //                         )),