import 'package:flutter/material.dart';
import 'package:ricoletta/coleta.dart' as Coleta;

class AddSitioView extends StatefulWidget {
  Coleta.Profile _profile;

  AddSitioView(this._profile);

  @override
  State<StatefulWidget> createState() => AddSitioViewState();
}

class AddSitioViewState extends State<AddSitioView> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
            title: Hero(
                tag: 'add_sitio',
                child: Wrap(
                  children: [
                    ImageIcon(AssetImage('assets/images/sitios.png')),
                    Text(' Sítios')
                  ],
                ))),
        body: Form(
          key: _formKey,
          child: Container(),
        ));
  }
}
