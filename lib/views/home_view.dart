import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ricoletta/views/add_animal_view.dart';
import 'package:ricoletta/views/add_produto_view.dart';
import 'package:ricoletta/views/login_view.dart';
import 'dart:math' as Math;

import 'add_sitios.dart';
import 'package:ricoletta/common.dart' as Common;
import 'package:ricoletta/coleta.dart' as Coleta;

enum AlertType { INFO, WARNING, ERROR }

class AlertBox {
  final AlertType type;
  final String message;

  AlertBox(this.message, {this.type = AlertType.INFO});
}

class AlertBoxWidget extends StatelessWidget {
  final List<dynamic> messages;

  AlertBoxWidget({super.key, required this.messages});

  List<Widget> _list() {
    if (messages == null) {
      return List.empty();
    }

    ListTile _(dynamic e) {
      if (e is AlertBox) {
        return ListTile(leading: Icon(Icons.info), title: Text(e.message));
      }

      return ListTile(
        leading: Icon(Icons.info),
        title: Text('$e'),
        trailing: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: Icon(Icons.close),
          onPressed: () {
            print('remover msg');
          },
        ),
        onTap: () {},
      );
    }

    return messages.map(_).toList();
  }

  @override
  Widget build(BuildContext context) {
    final alerts = _list();

    return Container(
      height: Math.min(120, alerts.length * 50),
      child: ListView(
          padding: EdgeInsets.only(top: 8, bottom: 8), children: alerts),
    );
  }
}

class StatsButtonWidget extends StatelessWidget {
  final num stats;
  final String subtitle;
  final Widget icon;
  final void Function()? onPressed;

  StatsButtonWidget(this.stats, this.subtitle, this.icon, [this.onPressed = null]);

  @override
  Widget build(BuildContext context) {
    return
      Card(
        child: ListTile(
          title: Text(
            '$stats',
            style: h1.copyWith(fontSize: 50),
          ),
          subtitle: Text('$subtitle',
              style: h1.copyWith(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.normal)),
          trailing: icon,
        ),
      )
      ;
  }
}

/****/
class HomeView extends StatefulWidget {

  Coleta.Profile profile;
  HomeView(this.profile);

  @override
  State<StatefulWidget> createState() => HomeViewState();

  Future<void> onRefresh() {
    print('Atualizar aqui ${profile.id}');
    return Coleta.getProfile(profile.id).then((data) {
      Coleta.storage.saveData(data);
      profile.update(data);
      print('Atualizada!');
    });
  }
}

const TextStyle h1 = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w900,
  color: Colors.black87,
);

class HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    AlertBoxWidget alertBoxWidget = AlertBoxWidget(messages: [
      // 'Saulo', 'Oliveira', 'Saulo', 'Oliveira'
    ]);

    bool hideAlertBox = alertBoxWidget.messages.isEmpty;

    Coleta.Profile currentProfile = this.widget.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ricoleta App Coleta'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  title: Text('Bem-vindo, ${currentProfile.nome}',
                      style: h1, textAlign: TextAlign.left),
                  // subtitle: hideAlertBox ? null : alertBoxWidget,
                ),

                alertBoxWidget,
                ListTile(
                  title: Text('Resumo', style: h1),
                ),
                Expanded(

                    child: GridView.count(
                      crossAxisCount: 2,

                      padding: EdgeInsets.all(16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        StatsButtonWidget(currentProfile.animais.length, "Animais", Common.OVINO_ICON),
                        StatsButtonWidget(currentProfile.produtos.length, "Produtos", Common.CARNE_ICON),
                        StatsButtonWidget(currentProfile.sitios.length, "Sítios", Common.SITIO_ICON),
                        StatsButtonWidget(currentProfile.avaliacoes, "Avaliações", Icon(Icons.star)),
                      ],
                    ),



                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        widget.onRefresh();
                      });
                    }, child: Text('Atualizar')),

                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LoginView()));
                    }, child: Text('Sair'))
                  ],
                ),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(
                //           builder: (context) => LoginView()));
                // }, child: Text('Sair'))
                //),
              ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          Widget screen;

          if (index == 0) {
            screen = AddAnimalView(widget.profile);
          } else if (index == 1) {
            screen = AddProdutoView(widget.profile);
          } else {
            screen = AddSitioView(widget.profile);
          }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Rebanho',
            icon: Hero(
                tag: 'add_animal',
                child: ImageIcon(AssetImage('assets/images/bode.png'))),
          ),
          BottomNavigationBarItem(
              icon: Hero(
                  tag: 'add_produto',
                  child: ImageIcon(AssetImage('assets/images/carnes.png'))),
              label: 'Produtos'),
          BottomNavigationBarItem(
              icon: Hero(
                  tag: 'add_sitio',
                  child: ImageIcon(AssetImage('assets/images/sitios.png'))),
              label: 'Sítios'),
        ],
      ),
    );
  }
}
