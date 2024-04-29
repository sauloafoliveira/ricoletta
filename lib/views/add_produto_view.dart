import 'package:flutter/material.dart';

class AddProdutoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddProdutoViewState();
}

class AddProdutoViewState extends State<AddProdutoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Hero(
              tag: 'add_produto',
              child: Icon(Icons.party_mode))
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text('Bem-vindo, Saulo!')
              
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheet(builder: (BuildContext context) {
        return Text('MDs');
      }, onClosing: () {
        print('fechando');
      },

      ),
    );
  }
}