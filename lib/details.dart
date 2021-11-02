import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsCars extends StatefulWidget {
  final String id;
  final String descricao;
  final String foto;
  final String marca;
  final ano;
  final valor;
  final String veiculo;

  const DetailsCars(
      {Key? key,
      required this.id,
      required this.descricao,
      required this.foto,
      required this.marca,
      required this.ano,
      required this.valor,
      required this.veiculo})
      : super(key: key);

  @override
  State<DetailsCars> createState() => _DetailsCarsState(
        id: this.id,
        descricao: this.descricao,
        foto: this.foto,
        marca: this.marca,
        ano: this.ano,
        valor: this.valor,
        veiculo: this.veiculo,
      );
}

class _DetailsCarsState extends State<DetailsCars> {
  var _edEmail = TextEditingController();
  final String id;
  final String descricao;
  final String foto;
  final String marca;
  final ano;
  final valor;
  final String veiculo;
  _DetailsCarsState({
    required this.id,
    required this.descricao,
    required this.foto,
    required this.marca,
    required this.ano,
    required this.valor,
    required this.veiculo,
  });

  CollectionReference cfVeiculos =
      FirebaseFirestore.instance.collection("garagem");

  Future<void> update() {
    var value = _edEmail.text;
    print(value);
    return cfVeiculos
        .doc(id)
        .update({'reserva': value})
        .then((value) =>
            {print("reserved vehicle"), _edEmail = '' as TextEditingController})
        .catchError((onError) => {print(onError)});
  }

  @override
  build(BuildContext context) {
    Object? data = {};
    return Scaffold(
      appBar: AppBar(
        title: Text('Garagem Avenida'),
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            // stream: cfVeiculos.snapshots(),
            builder: (context, snapshot) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Center(child: Image.network(foto)),
                  ),
                  Container(
                    height: 50,
                    child: Center(child: Text('Veículo ${marca} - ${veiculo}')),
                  ),
                  Container(
                    height: 50,
                    child: Center(child: Text('Ano ${ano.toString()}')),
                  ),
                  Container(
                    height: 50,
                    child: Center(child: Text('Detalhes ${descricao}')),
                  ),
                  Container(
                    height: 50,
                    child: Center(child: Text('Valor ${valor}')),
                  ),
                  Container(
                    height: 50,
                    child: Center(
                      child: TextFormField(
                        controller: _edEmail,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          labelText: "Reservar",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                        onPressed: update,
                        child: Text(
                          "Reservar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
