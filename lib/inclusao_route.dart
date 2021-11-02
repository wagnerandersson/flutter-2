import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InclusaoRoute extends StatefulWidget {
  const InclusaoRoute({Key? key}) : super(key: key);

  @override
  _InclusaoRouteState createState() => _InclusaoRouteState();
}

class _InclusaoRouteState extends State<InclusaoRoute> {
  var _edVeiculo = TextEditingController();
  var _edMarca = TextEditingController();
  var _edDescricao = TextEditingController();
  var _edPreco = TextEditingController();
  var _edAno = TextEditingController();
  var _edFoto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inclusão de Veículos'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Voltar',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Container _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edVeiculo,
            keyboardType: TextInputType.name,
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Veículo",
            ),
          ),
          TextFormField(
            controller: _edMarca,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Marca",
            ),
          ),
          TextFormField(
            controller: _edDescricao,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Descrição",
            ),
          ),
          TextFormField(
            controller: _edAno,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Ano",
            ),
          ),
          TextFormField(
            controller: _edPreco,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Preço R\$",
            ),
          ),
          TextFormField(
            controller: _edFoto,
            keyboardType: TextInputType.url,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Foto",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
                onPressed: _gravaDados,
                child: Text(
                  "Cadastrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> _gravaDados() async {
    if (_edVeiculo.text == "" ||
        _edMarca.text == "" ||
        _edDescricao.text == "" ||
        _edAno.text == "" ||
        _edPreco.text == "" ||
        _edFoto.text == "") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Atenção '),
              content: Text('Preencha todos os dados'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok')),
              ],
            );
          });
      return;
    }

    CollectionReference cfCarros =
        FirebaseFirestore.instance.collection("garagem");

    await cfCarros.add({
      "veiculo": _edVeiculo.text,
      "marca": _edMarca.text,
      "descricao": _edDescricao.text,
      "ano": double.parse(_edAno.text),
      "valor": double.parse(_edPreco.text),
      "foto": _edFoto.text,
    });

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cadastro Concluído '),
            content: Text(
                'O Veículo ${_edVeiculo.text} foi inserido na base de dados'),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok')),
            ],
          );
        });

    _edVeiculo.text = "";
    _edMarca.text = "";
    _edDescricao.text = "";
    _edAno.text = "";
    _edPreco.text = "";
    _edFoto.text = "";
  }
}
