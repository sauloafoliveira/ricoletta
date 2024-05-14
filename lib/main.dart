import 'package:flutter/material.dart';
import 'package:ricoletta/profile_view.dart';
import 'package:ricoletta/views.dart';
import 'package:ricoletta/backend.dart' as BackEnd;
import 'package:flutter/material.dart';
import 'package:ricoletta/animal_view.dart';
import 'package:ricoletta/views/home_view.dart';
import 'package:ricoletta/ricoleta.dart' as RicoColeta;
import 'package:ricoletta/views/login_view.dart';

void main() {

  runApp(new MaterialApp( home:  LoginView()));




  return;

  runApp(new MaterialApp(
      debugShowMaterialGrid: true,
      home: FutureBuilder(
    future: RicoColeta.getProdutor(),
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done) {

        List<dynamic> result = (snapshot.data ?? []) as List<dynamic>;

        if (result.isEmpty) {
          return HomeView(RicoColeta.Produtor.mock());
        }
        final p = RicoColeta.Produtor(result[0]);
        return HomeView(p);
      }
      else if(snapshot.hasError) {
        return Center(
          child: Text('Deu ruim'),
        );
      }
      else {
        return Center(
          child: Text('Carregando'),
        );
      }
    },
  )));
  //
  // RicoColeta.getProdutor().then((value) {
  //   print(value);
  //
  //   List<dynamic> result = value as List<dynamic>;
  //   final p = RicoColeta.Produtor(value[0]);
  //   print(p.animais);
  //   print(p.produtos);
  //
  //   runApp(new MaterialApp(home: FutureBuilder(
  //     future: ,
  //   )));
  // }).onError((error, stackTrace) {
  //   print('Erro: $error');
  // });


}


class ProfileView extends StatelessWidget {
  final RicoColeta.Produtor produtor;

  const ProfileView({super.key, required this.produtor});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Ricoleta'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.usb,
              color: Colors.red,
              size: 100,
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Text(produtor.nome),
                  Text(produtor.cpfOuCnpj),
                  Text(produtor.email),
                ])),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(8),
              children: [
                Text('Sítios produtores', textAlign: TextAlign.center),
                Text('Animais', textAlign: TextAlign.center),
                Text('Produtos', textAlign: TextAlign.center),
                Text('4', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('6', textAlign: TextAlign.center)
              ],
            )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnimalView()),
                        );
                      },
                      child: Text('Adicionar animal'));
                }),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnimalView()),
                      );
                    },
                    child: Text('Adicionar animal')),
                ElevatedButton(
                    onPressed: () {
                      print(1);
                    },
                    child: Text(
                      'Adicionar produto',
                    ))
              ],
            ),
            Expanded(
                child: Container(
              height: 100,
            )),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.ac_unit), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
