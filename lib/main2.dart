import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: adicionar,
          tooltip: 'Adicionar Suco',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  CollectionReference cfSucos = FirebaseFirestore.instance.collection("sucos");

  Future<void> adicionar() async {
    await Firebase.initializeApp();

    cfSucos.add({
      "fruta": "Abacaxi",
      "marca": "Del Vale",
      "preco": 6.50,
      "foto":
          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.paodeacucar.com%2Fproduto%2F12263%2Fsuco-del-valle-nectar-sabor-abacaxi-tp-1l&psig=AOvVaw0JU_Yh02ceRZo1JXrUO1Ah&ust=1633043067926000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKDTwdGlpfMCFQAAAAAdAAAAABAD"
    });
  }
}
