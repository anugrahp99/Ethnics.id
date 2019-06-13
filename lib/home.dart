import 'dart:io';

import 'package:flutter/material.dart';
import 'profile.dart';
import 'homepage.dart';
import 'toko.dart';
import 'berita.dart';
import 'statusinvestasi.dart';
import 'statusproduk.dart';
import 'keranjangproduk.dart';

class MyHomePage extends StatefulWidget {
  final String email;
  final String password;
  MyHomePage(this.email, this.password);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  IconData icon = Icons.assignment_turned_in;
  String judul = "ID";
  Widget _body ;

@override
void initState(){
super.initState();
_body =  HomePage(widget.email);
}

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        _body = HomePage(widget.email);
        icon = Icons.assignment_turned_in;
        judul = "INVEST";
      } else if (index == 1) {
        _body = TokoPage(widget.email);
        icon = Icons.shopping_basket;
        judul = "TOKO";
      } else if (index == 2) {
        _body = BeritaPage();
        icon = null;
        judul = "BERITA";
      } else if (index == 3) {
        _body = ProfilePage(widget.email,widget.password);
        icon = null;
        judul = "ID";
      }
    });
  }

  void ujungkanan() {
    if (_currentIndex == 0) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new StatusInvestasiPage(widget.email)));
    } else if (_currentIndex == 1) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new KeranjangPage(widget.email)));
    }
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
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.green[700],
                selectedFontSize: 14.0,
                currentIndex: _currentIndex,
                unselectedItemColor: Colors.grey[700],
                items: [
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), title: Text("Toko")),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.assignment), title: Text("Berita")),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text("Profile")),
                ],
                onTap: onTabTapped,
              ),
              drawer:new Drawer(
        child: new ListView(
          children: <Widget>[
            
            new ListTile(
              title: new Text("Investasiku"),
              trailing: new Icon(Icons.assignment_turned_in),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HomePage(widget.email)));
              }
            ),
            new ListTile(
              title: new Text("Orderanku"),
              trailing: new Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new TokoPage(widget.email)));
              }
            ),
            new ListTile(
              title: new Text("SignOut"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: ()=> 
                exit(1)
            
            ),
            
          ]
        )
        ),
              backgroundColor: Colors.transparent,
              appBar: new AppBar(
                centerTitle: true,
                actions: <Widget>[
                  GestureDetector(
                    child: new Icon(icon),
                    onTap: () {
                      ujungkanan();
                    },
                  )
                ],
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ET",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "HNICS." + judul,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: _body),
        ],
      ),
    );
  }
}
