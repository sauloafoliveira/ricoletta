import 'package:flutter/material.dart';

class AddProdutoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddProdutoViewState();
}

class AddProdutoViewState extends State<AddProdutoView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(tag: 'add_produto', child: Icon(Icons.party_mode))),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 16),
          )),
      bottomSheet: BottomSheet(
        builder: (BuildContext context) {
          return Text('MDs');
        },
        onClosing: () {
          print('fechando');
        },
      ),
    );
  }
}
