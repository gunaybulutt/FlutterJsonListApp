import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basic_json_list_app/il.dart';
import 'package:flutter_basic_json_list_app/ilce.dart';

class FirstPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> {

  List<Il> iller = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _jsonGetter();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Json List"),
      ),
      body: ListView.builder(
        itemCount: iller.length,
        itemBuilder:  _listCreator,
      ),
    );
  }

  Widget _listCreator(BuildContext context, int index) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(iller[index].name),
            Text(iller[index].cityNumber),
        ],),
        leading: Icon(Icons.location_city),
        children: iller[index].ilceler.map((ilce){
          return ListTile(
            title: Text(ilce.name),
          );
        }).toList()
      ),
    );
  }

  void _jsonGetter() async {
    //dosyayı okuyup string türünde bir değişkene atar
    String jsonString = await rootBundle.loadString("assets/iller_ilceler.json");
    //string türünde değişkenin decode ediyoruz ve map'e dönüştürüyoruz
    Map<String, dynamic> illerMap = json.decode(jsonString);

    for(String plakaKodu in illerMap.keys){
      Map<String, dynamic> ilMap = illerMap[plakaKodu];
      //print(ilMap[0]);
      String ilName = ilMap["name"];
      Map<String, dynamic> ilcelerMap = ilMap["districts"];
      print(ilcelerMap);

      List<Ilce> tumIlceler = [];

      for (String ilceKodu in ilcelerMap.keys){
        Map<String, dynamic> ilceMap = ilcelerMap[ilceKodu];
        String ilceIsmi = ilceMap["name"];
        Ilce ilce = Ilce(ilceIsmi);
        tumIlceler.add(ilce);
      }

      Il il = Il(ilName, plakaKodu, tumIlceler);
      iller.add(il);
    }

    setState(() {});
  }


}