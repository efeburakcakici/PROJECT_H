import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_h/model/loadData.dart';
import 'package:project_h/page/travel_page.dart';
import 'package:project_h/page/transaction_page.dart';
import 'package:http/http.dart' as http;

class Loginmain extends StatefulWidget {
  const Loginmain({Key? key}) : super(key: key);

  @override
  State<Loginmain> createState() => _LoginmainState();
}

class _LoginmainState extends State<Loginmain> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<LoadData> apiCall() async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=michael'));

    if (response.statusCode == 200) {
      return LoadData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Yüklenemedi');
    }
  }

  Future<void> girisKontrol(name, pass) async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if (ka == "admin" && s == "123") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TransactionPage()));
    } else if (ka == "efe" && s == "123") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TravelApp()));
    } else if (ka == name && s == pass) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TravelApp()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Giriş Hatalı.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LoadData>(
        future: apiCall(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS2VegytIKIrumf9mfMhSm_OQsWQ4vKnOlIA&usqp=CAU"),
                      TextField(
                        controller: tfKullaniciAdi,
                        decoration:
                            InputDecoration(hintText: "Kullanıcı adı giriniz"),
                      ),
                      TextField(
                        controller: tfSifre,
                        decoration: InputDecoration(
                          hintText: "Sifre giriniz",
                        ),
                        obscureText: true,
                      ),
                      ElevatedButton(
                        child: Text("Giriş Yap"),
                        onPressed: () {
                          girisKontrol(snapshot.data?.name,
                              snapshot.data?.count.toString());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
