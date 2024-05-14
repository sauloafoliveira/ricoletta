import 'package:flutter/material.dart';
import 'package:ricoletta/views/add_animal_view.dart';
import 'package:ricoletta/views/add_produto_view.dart';
import 'dart:math' as Math;
import 'package:ricoletta/ricoleta.dart' as RicoColeta;

import '../ricoleta.dart';

enum AlertType {
  INFO, WARNING, ERROR
}

class AlertBox {
  final AlertType type;
  final String message;

  AlertBox(this.message, {this.type = AlertType.INFO});
}

class AlertBoxWidget extends StatelessWidget {

  final List<dynamic> messages;

  AlertBoxWidget({super.key, required this.messages});

  List<Widget> _list() {

    if(messages == null) {
      return List.empty();
    }

    ListTile _(dynamic e) {
      if( e is AlertBox ) {
        return ListTile(
            leading: Icon(Icons.info),
            title: Text(e.message)
        );
      }

      return ListTile(
          leading: Icon(Icons.info),
          title: Text('$e'),
          trailing: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Icon(Icons.close),
            onPressed: (){
              print('remover msg');
            },
          ),
        onTap: (){},
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
        padding: EdgeInsets.only(top: 8, bottom: 8),

        children: alerts
      ),
    );
  }
}

class StatsButtonWidget extends StatelessWidget {

  final num stats;
  final String subtitle;
  final void Function()? onPressed;

  StatsButtonWidget(this.stats, this.subtitle, [this.onPressed = null]);

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(child:
          ListTile(
            title: Text('$stats', style: h1.copyWith(fontSize: 50),),
            subtitle: Text('$subtitle', style: h1.copyWith(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.assessment_outlined, size: 50),
          ), onPressed: onPressed);


  }
}

/****/
class HomeView extends StatefulWidget {
  Produtor _produtor;

  HomeView(this._produtor);

  @override
  State<StatefulWidget> createState() => HomeViewState();
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
                title: Text('Bem-vindo, ${this.widget._produtor.nome}!', style: h1,textAlign: TextAlign.left),
               // subtitle: hideAlertBox ? null : alertBoxWidget,
              ),

              alertBoxWidget,
              ListTile(
                title: Text('Resumo', style: h1),
              ),
              Expanded(
                  //
                  // child: Container(
                  //   padding: EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //
                  //       border: Border.all(
                  //         color: Colors.white,
                  //       ),
                  //       borderRadius: BorderRadius.all(Radius.circular(20))
                  //   ),
                    child:

                    GridView.count(

                      crossAxisCount: 2,
                      padding: EdgeInsets.all(16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,

                      children: [
                        StatsButtonWidget(120, "Animais", (){}),
                        StatsButtonWidget(120, "Produtos"),
                        StatsButtonWidget(120, "Sítios"),
                        StatsButtonWidget(120, "Avaliações"),

                      ],
                    ),
                  )
              //),


            ]
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {

          Widget screen = (index == 0) ? AddAnimalView() : AddProdutoView();
          Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));

        },
        items: const [
          BottomNavigationBarItem(
            label: 'Rebanho',
            icon: Hero(tag: 'add_animal', child: Icon(Icons.paragliding)),
          ),
          BottomNavigationBarItem(
              icon: Hero(tag: 'add_produto', child: Icon(Icons.cake)), label: 'Produtos'),

        ],
      ),
    );
  }
}
