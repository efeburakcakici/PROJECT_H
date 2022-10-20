import 'package:flutter/material.dart';
import 'package:project_h/page/travel_page.dart';

class Prices extends StatefulWidget {
  const Prices({Key? key}) : super(key: key);

  @override
  State<Prices> createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TravelApp() ));
            },
          ),
        title: Text("Fiyatlar"),
          centerTitle: true,
    ),
    body:


      ListView(
      children: <Widget>[

        SizedBox(height: 10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.black, height: 30,),
        ),

        Card(
          margin: EdgeInsets.all(10),
          elevation:20,
          color: Colors.purple[200],
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.hotel),radius: 15,),
            title: Text("PLAZA OTEL"),
            subtitle: Text("Bartın-Tek Kişi"),
            trailing: Text("150 \$"),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.black, height: 30,),
        ),

        Card(
          margin: EdgeInsets.all(10),
          elevation:20,
          color: Colors.lightBlue[200],
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.hotel),radius: 15,),
            title: Text("REX OTEL"),
            subtitle: Text("İstanbul-Tek Kişi"),
            trailing: Text("150 \$"),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.black, height: 30,),
        ),

        Card(
          margin: EdgeInsets.all(10),
          elevation:20,
          color: Colors.red[200],
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.hotel),radius: 15,),
            title: Text("ANKARA OTEL "),
            subtitle: Text("Adana"),
            trailing: Text("150 \$"),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.black, height: 30,),
        ),

      ],


    )
    );
  }
}
