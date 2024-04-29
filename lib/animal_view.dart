import 'package:flutter/material.dart';
import 'package:ricoletta/backend.dart';
import 'package:ricoletta/models.dart';

class AnimalView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimalViewState();
}

class AnimalViewState extends State<AnimalView> {
  @override
  Widget build(BuildContext context) {

    final RicoService _ricoService = RicoService(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de animais'),
      ),
      body: FutureBuilder(
        future: _ricoService.fetchAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            //return Center(child: Text('Error: ${snapshot.error}'));
            return Center(child: Text('Sem dados a serem carregados.'));
          } else {

            List s = snapshot.data!;
            return ListView.separated(

              itemCount: s!.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),

              itemBuilder: (context, index) {

                var animal = s.elementAt(index) as Animal;

                return ListTile(
                  iconColor: animal.abatimento != null ? Colors.red : Colors.green,

                  horizontalTitleGap: 2,
                  leading: Icon(Icons.adb),
                  title: Text('$animal'),
                  subtitle: Text('${animal.produtor["cpf_ou_cpnj"]}'),
                  trailing: Icon(Icons.remove_circle),
                );
              },
            );
          }
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.supervised_user_circle),
          title: Text('Conectado como ${_ricoService.userId}', style: TextStyle(fontSize: 12),),
          subtitle: Text('CPF/CPNJ: ${_ricoService.userId}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () {

        },
      ),
    );
  }
}
