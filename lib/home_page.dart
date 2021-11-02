import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_avenida/details.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'inclusao_route.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? filtro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garagem Avenida'),
        actions: [
          IconButton(
            onPressed: () {
              _showFilter(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                filtro = null;
              });
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        // onPressed: adicionar,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InclusaoRoute()),
          );
        },
        tooltip: 'Cadastrar Veículo',
        child: const Icon(Icons.add),
      ),
    );
  }

  CollectionReference cfCarros =
      FirebaseFirestore.instance.collection("garagem");

  String id = " ";

  Column _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            // stream: cfCarros.snapshots(),
            stream: cfCarros.where("veiculo", isEqualTo: filtro).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(
                        data.docs[index].get('foto'),
                      ),
                    ),
                    title: Text(data.docs[index].get('veiculo')),
                    subtitle: Text(data.docs[index].get('descricao') +
                        "\n" +
                        NumberFormat.simpleCurrency(locale: "pt_BT")
                            .format(data.docs[index].get('valor'))),
                    isThreeLine: true,
                    onTap: () {
                      // print(id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsCars(
                                id: data.docs[index].id,
                                ano: data.docs[index].get('ano'),
                                descricao: data.docs[index].get('descricao'),
                                foto: data.docs[index].get('foto'),
                                marca: data.docs[index].get('marca'),
                                valor: data.docs[index].get('valor'),
                                veiculo: data.docs[index].get('veiculo')),
                          ));
                    },
                    onLongPress: () {
//                      print("Clicou");
//                      print(data.docs[index].get("fruta"));
//                      print(data.docs[index].id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Exclusão'),
                            content: Text(
                                'Confirma a exclusão do ${data.docs[index].get("veiculo")}?'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  cfCarros.doc(data.docs[index].id).delete();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Future<void> _showFilter(BuildContext context) async {
    String? valueText;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Busca'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              decoration: InputDecoration(hintText: "Digite o nome do veículo"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Cancelar'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    filtro = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
