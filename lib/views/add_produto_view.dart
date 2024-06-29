import 'package:flutter/material.dart';
import 'package:ricoletta/coleta.dart' as Coleta;

class AddProdutoView extends StatefulWidget {

  Coleta.Profile _profile;
  AddProdutoView(this._profile);

  @override
  State<StatefulWidget> createState() => AddProdutoViewState();
}

class ProdutoCard extends StatelessWidget {
  final String informacoes;
  final String corte;
  final int avaliacao;

  ProdutoCard(
      {super.key,
      required this.informacoes,
      required this.corte,
      this.avaliacao = 0});

  @override
  Widget build(BuildContext context) {
    String aval = this.corte == 0 ? "Sem avaliação" : "${this.avaliacao}/5";
    return ListTile(
      leading: ImageIcon(
        AssetImage('assets/images/produto.png'),
        size: 48,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${this.corte}"),
          Text(aval),
        ],
      ),
      subtitle: Text("${this.informacoes}"),
    );
  }
}

class AddProdutoViewState extends State<AddProdutoView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(
              tag: 'add_produto',
              child: Wrap(
                children: [
                  ImageIcon(AssetImage('assets/images/carnes.png')),

                  Text(' Produtos')
                ],
              ))),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 16),

            children: [
              Text('Aqui, você pode observar os cards de produtos'),
              ProdutoCard(
                informacoes:
                    'Nesse sistema, os ovinos são criados soltos no pasto sem necessida- de de instalações grandiosas e uso de tecnologias de produção.',
                corte: 'Picanha',
                avaliacao: 3,
              ),
              ProdutoCard(
                informacoes:
                'Nesse sistema, os ovinos são criados soltos no pasto sem necessida- de de instalações grandiosas e uso de tecnologias de produção.',
                corte: 'Picanha',
                avaliacao: 3,
              )
              ,
              ProdutoCard(
                informacoes:
                'Nesse sistema, os ovinos são criados soltos no pasto sem necessida- de de instalações grandiosas e uso de tecnologias de produção.',
                corte: 'Picanha',
                avaliacao: 3,
              ),
              ProdutoCard(
                informacoes:
                'Nesse sistema, os ovinos são criados soltos no pasto sem necessida- de de instalações grandiosas e uso de tecnologias de produção.',
                corte: 'Picanha',
                avaliacao: 3,
              )
            ],
          )),
      bottomSheet: BottomSheet(
        builder: (BuildContext context) {
          return ListTile(
            leading: Icon(Icons.link),
            title: Text('Conectado como:'),
            trailing: Text('Saulo Oliveira',
                style: TextStyle(fontWeight: FontWeight.bold)),
          );
        },
        onClosing: () {
          print('fechando');
        },
      ),
    );
  }
}
