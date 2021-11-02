import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Garagem Avenida',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}


// TODO exibir a lista de sucos em ordem alfabetica de fruta
// TODO criar uma nova activity para fazer a inclusão de novos sucos
// TODO ao dar um clicke longo sobre um item da lista, solicitar confirmação e excluir o item