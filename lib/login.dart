import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'dart:convert';
import 'dart:async';
import 'penjualHome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin<LoginPage> {
  // var authHandler = new Auth();
  String msg = "";
  String identifier = '0';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  WidgetMarker selectedWidgetMarker = WidgetMarker.pembeli;
  AnimationController _controller;
  Animation _animation;
  Color _pembeli;
  Color _penjual;
  Color _textPembeli;
  Color _textPenjual;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  Future _loginPembeli() async {
    final response =
        await http.post("http://ethnics.000webhostapp.com/login.php", body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
  var datauser = json.decode(response.body);
  print(datauser);
    if (datauser.length == 0) {
      emailController.text = "";
      passwordController.text= "";
        showDialog(
              barrierDismissible: false,
              context: context,
              child: new CupertinoAlertDialog(
                title: new Text("ETHNICS"),
                content: new Text("Email atau password anda salah\nSilahkan Login kembali !"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                         Navigator.pop(context);
                      },
                      child: new Text("OK"))
                ],
              ),
            );
      
    } else {
      
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new MyHomePage(emailController.text,passwordController.text)));
      
    }
  }
  Future _loginPenjual() async {
    final response =
        await http.post("http://ethnics.000webhostapp.com/login.php", body: {
      "email": emailController.text,
      "password": passwordController.text,
    }
    );

    var datauser = json.decode(response.body);
    print(datauser);
    if (datauser == "[]") {
      showDialog(
              barrierDismissible: false,
              context: context,
              child: new CupertinoAlertDialog(
                title: new Text("ETHNICS"),
                content: new Text("Email atau password anda salah\nSilahkan Login kembali !"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                         Navigator.pop(context);
                      },
                      child: new Text("OK"))
                ],
              ),
            );
      emailController.text = "";
      passwordController.text= "";

    } else {
     
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new PenjualHomePage()));
      
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _pembeli = Colors.green[800];
    _penjual = Colors.white;
    _textPembeli = Colors.white;
    _textPenjual = Colors.green[800];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Center(
              heightFactor: 5.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ET",
                    style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "HNICS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _pembeli = Colors.green[800];
                      _penjual = Colors.white;
                      _textPembeli = Colors.white;
                      _textPenjual = Colors.green[800];
                      selectedWidgetMarker = WidgetMarker.pembeli;
                    });
                  },
                  child: Text(
                    "Pembeli",
                    style: TextStyle(color: _textPembeli),
                  ),
                  color: _pembeli,
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _pembeli = Colors.white;
                      _penjual = Colors.green[800];
                      _textPembeli = Colors.green[800];
                      _textPenjual = Colors.white;
                      selectedWidgetMarker = WidgetMarker.penjual;
                    });
                  },
                  color: _penjual,
                  child: Text(
                    "Penjual",
                    style: TextStyle(color: _textPenjual),
                  ),
                )
              ],
            ),
            FutureBuilder(
              future: _playAnimation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return getCustomContainer();
              },
            )
          ],
        ),
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.pembeli:
        return getPembeliContainer();
      case WidgetMarker.penjual:
        return getPenjualContainer();
    }
    return getPembeliContainer();
  }

  Widget getPembeliContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 17, 0),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.green[800],
                    size: 24.0,
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: "Masukan email",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[600]))),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 17, 0),
                  child: Icon(
                    Icons.lock_outline,
                    size: 22.0,
                    color: Colors.green[800],
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _formKey2,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: "Masukan password",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[600]))),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: FlatButton(
              child: Center(
                child: Text(
                  "Masuk",
                  style: TextStyle(color: Colors.green[700]),
                ),
              ),
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey1.currentState.validate() &&
                    _formKey2.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar

                    _loginPembeli();

                }
              },
              color: Colors.white,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Belum memiliki akun ?",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Segoe UI',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MySignUpPage()));
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.red, fontFamily: 'Segoe UI'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getPenjualContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 17, 0),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.green[800],
                    size: 24.0,
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Masukan email",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[600]))),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 17, 0),
                  child: Icon(
                    Icons.lock_outline,
                    size: 22.0,
                    color: Colors.green[800],
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _formKey2,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      obscureText: true,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: "Masukan password",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[600]))),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: FlatButton(
              child: Center(
                child: Text(
                  "Masuk",
                  style: TextStyle(color: Colors.green[700]),
                ),
              ),
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey1.currentState.validate() &&
                    _formKey2.currentState.validate()) {

                    _loginPenjual();
                }
              },
              color: Colors.white,
            ),
          ),
          Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Belum memiliki akun ?",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Segoe UI',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MySignUpPage()));
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.red, fontFamily: 'Segoe UI'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
