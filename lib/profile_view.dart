import 'package:flutter/material.dart';
import 'package:ricoletta/animal_view.dart';
import 'package:ricoletta/models.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Produtor p =
        Produtor('000.000.000-01', 'saulo@ifce.edu.br', 'Saulo Oliveira');

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
                  Text(p.nome),
                  Text(p.cpfOuCnpj),
                  Text(p.email),
                ])),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(8),
              children: [
                Text('1', textAlign: TextAlign.center),
                Text('2', textAlign: TextAlign.center),
                Text('3', textAlign: TextAlign.center),
                Text('4', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('6', textAlign: TextAlign.center)
              ],
            )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AnimalView()),
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
