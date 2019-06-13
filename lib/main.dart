import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETHNICS',
      theme: ThemeData(
          accentIconTheme: IconThemeData(color: Colors.green[600]),
          splashColor: Colors.green[600]),
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: MyLoginPage(),
    );
  }
}

enum WidgetMarker { pembeli, penjual }

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage>
    with SingleTickerProviderStateMixin<MyLoginPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ET",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "HNICS.ID",
                            style: TextStyle(
                                fontSize: 36.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green[700]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Text(
                        "Raise Up Small Textile Industry",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
