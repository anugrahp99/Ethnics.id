import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'penjualHome.dart';
import 'login.dart';

class MySignUpPage extends StatefulWidget {
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

enum WidgetMarker { pembeli, penjual }

class _MySignUpPageState extends State<MySignUpPage> with SingleTickerProviderStateMixin<MySignUpPage> {

void daftarPembeli(){
  print(_controllerDate.text);
  print(convertDate(_controllerDate.text));
  var url="http://ethnics.000webhostapp.com/daftarPembeli.php?email_pembeli="+emailController.text+"&password="+passwordController.text+"&nama="+namaController.text+"&tanggal_lahir="+convertDate(_controllerDate.text)+"&nomor_handphone="+nomorController.text+"&jenis_kelamin="+_color;
  print(url);
  http.get(url);
  showDialog(
              barrierDismissible: false,
              context: context,
              child: new CupertinoAlertDialog(
                title: new Text("ETHNICS"),
                content: new Text("Pendaftaran telah Berhasil\nSilahkan Login"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                         Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage()));
                      },
                      child: new Text("OK"))
                ],
              ),
            );
    
}
void daftarPenjual(){
  var url="http://ethnics.000webhostapp.com/daftarPenjual.php?email_pembeli="+emailController.text+"&password="+passwordController.text+"&nama="+namaController.text+"&tanggal_lahir="+convertDate(_controllerDate.text)+"&nomor_handphone="+nomorController.text+"&jenis_kelamin="+_color;
  http.get(url);
     Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage()));

}


TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController passwordController2 = new TextEditingController();
TextEditingController namaController = new TextEditingController();
TextEditingController nomorController = new TextEditingController();






  List<String> _colors = <String>['', 'Laki - Laki', 'Perempuan'];
  String _color = '';
  final TextEditingController _controllerDate = new TextEditingController();

  String convertDate(String input){
    //                                09/09/2019
    String hasil = input.substring(6,10)+"-"+input.substring(3,5)+"-"+input.substring(0,2);
    return hasil;
  }

  WidgetMarker selectedWidgetMarker = WidgetMarker.pembeli;
  AnimationController _controller;
  Animation _animation;
  Color _pembeli;
  Color _penjual;
  Color _textPembeli;
  Color _textPenjual;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
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
              heightFactor: 2.5,
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
            margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      controller: namaController,
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
                          hintText: "Nama lengkap",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: new Row(children: <Widget>[
              new Expanded(
                  child: Form(
                key: _formKey2,
                child: new TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green[600])),
                    hintText: 'Tanggal lahir (DD/MM/YYYY)',
                  ),
                  controller: _controllerDate,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
              )),
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: new FormField<String>(
                    
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        
                        baseStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[600])),
                          hintText: 'Jenis kelamin',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(

                          child: new DropdownButton<String>(
                            
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
                              
                              return new DropdownMenuItem<String>(
                                value: value,


                                child: new Text(value,style: TextStyle(
                                  
                          fontFamily: 'Segoe UI',
                          color: Colors.green,
                          fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                          ),
                        ),

                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Pilih jenis kelamin';
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey3,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Email",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey4,
                    child: TextFormField(
                      controller: nomorController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Nomor handphone",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey5,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Password",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey6,
                    child: TextFormField(
                      controller: passwordController2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Ketik ulang password",
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
                  "Daftar",
                  style: TextStyle(color: Colors.green[700]),
                ),
              ),
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey1.currentState.validate() &&
                    _formKey2.currentState.validate() &&
                    _formKey3.currentState.validate() &&
                    _formKey4.currentState.validate() &&
                    _formKey5.currentState.validate() &&
                    _formKey6.currentState.validate()&& (passwordController.text==passwordController2.text) ) {
                  daftarPembeli();

                }
              },
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sudah memiliki akun ?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyLoginPage()));
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(color: Colors.red, fontFamily: 'Segoe UI'),
                  ),
                )
              ],
            ),
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
            margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      controller: namaController,
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
                          hintText: "Nama lengkap",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: new Row(children: <Widget>[
              new Expanded(
                  child: Form(
                key: _formKey2,
                child: new TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green[600])),
                    hintText: 'Tanggal lahir (DD/MM/YYYY)',
                  ),
                  controller: _controllerDate,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
              )),
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        baseStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[600])),
                          hintText: 'Jenis kelamin',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Pilih jenis kelamin';
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey3,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Email",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey4,
                    child: TextFormField(
                      controller: nomorController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Nomor handphone",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey5,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Password",
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
            margin: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey6,
                    child: TextFormField(
                      controller: passwordController2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Ketik ulang password",
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
                    _formKey2.currentState.validate() &&
                    _formKey3.currentState.validate() &&
                    _formKey4.currentState.validate() &&
                    _formKey5.currentState.validate() &&
                    _formKey6.currentState.validate()&& (passwordController==passwordController2) ) {
                  // If the form is valid, we want to show a Snackbar
                  daftarPenjual();
                }
              },
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sudah memiliki akun ?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyLoginPage()));
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(color: Colors.red, fontFamily: 'Segoe UI'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
